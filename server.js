const coap = require("coap"); // Import package CoAP
const mysql = require("mysql2"); // Import package MySQL
const express = require("express");
const routes = require("./routes"); // Import routes
const viewController = require("./viewController"); // Import viewController
const app = express();

// Koneksi ke MySQL database
const db = mysql.createConnection({
  host: "localhost", // Ganti dengan host database MySQL-mu
  user: "root", // Ganti dengan username MySQL-mu
  password: "", // Ganti dengan password MySQL-mu
  database: "grape_db", // Nama database yang kamu gunakan
});

// Tes koneksi database
db.connect((err) => {
  if (err) {
    console.error("Database connection error:", err);
    return;
  }
  console.log("Connected to MySQL database");
});

// Middleware untuk akses db di req
app.use((req, res, next) => {
  req.db = db;
  next();
});
app.use(express.static("assets"));
// Set view engine to EJS
app.set("view engine", "ejs");

// Gunakan routes untuk mengatur endpoint
app.use("/", routes);
app.set("views", "./views");

// Buat server HTTP
const httpPort = 3000;
app.listen(httpPort, () => {
  console.log(`HTTP server is running on http://localhost:${httpPort}`);
});

// Buat server CoAP
const server = coap.createServer();

// Handle incoming CoAP requests
server.on("request", (req, res) => {
  console.log("Received request:", req.url);

  if (req.method === "POST" && req.url === "/sensor") {
    console.log("Receiving new sensor data");
    let body = "";

    req.on("data", (chunk) => {
      body += chunk;
    });

    req.on("end", () => {
      try {
        const sensorData = JSON.parse(body);
        const { node_id, delay, payload_size, throughput, current, voltage, power, power_consumption, temperature, humidity, soil_moisture_data } = sensorData;

        // Query untuk menyimpan data
        const updateSql = "UPDATE node_send_logs SET delay = ?, payload_size = ?, throughput = ? WHERE node_id = ? ORDER BY created_at DESC LIMIT 1";
        db.query(updateSql, [delay, payload_size, throughput, node_id], (err, updateResult) => {
          if (err) {
            console.error("Error updating previous row in node_send_logs:", err);
            return;
          }

          const logSql = "INSERT INTO node_send_logs (node_id, delay, payload_size, throughput, created_at) VALUES (?, NULL, NULL, NULL, NOW())";
          db.query(logSql, [node_id], (err, logResult) => {
            if (err) {
              console.error("Error inserting data into node_send_logs:", err);
              return;
            }

            const logId = logResult.insertId;

            if (current != undefined && voltage != undefined && power_consumption != undefined && power != undefined) {
              const inaSql = "INSERT INTO ina (log_id, current, voltage, power, power_consumption, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
              db.query(inaSql, [logId, current, voltage, power, power_consumption], (err) => {
                if (err) console.error("Error inserting data into ina:", err);
              });
            }

            if (temperature != undefined && humidity != undefined) {
              const dhtSql = "INSERT INTO dht (log_id, temperature, humidity, created_at) VALUES (?, ?, ?, NOW())";
              db.query(dhtSql, [logId, temperature, humidity], (err) => {
                if (err) console.error("Error inserting data into dht:", err);
              });
            }

            if (Array.isArray(soil_moisture_data)) {
              soil_moisture_data.forEach((soilData) => {
                const { sensor_order, moisture } = soilData;
                const soilSql = "INSERT INTO soil_moisture (log_id, sensor_order, moisture, created_at) VALUES (?, ?, ?, NOW())";
                db.query(soilSql, [logId, sensor_order, moisture], (err) => {
                  if (err) console.error("Error inserting data into soil_moisture:", err);
                });
              });
            }

            res.code = "2.01"; // Set CoAP status untuk "Created"
            res.end("Sensor data inserted successfully");
            console.log("Sensor data inserted into all relevant tables");
          });
        });
      } catch (error) {
        console.error("Invalid JSON format:", error);
        res.code = "4.00"; // Set kode error untuk "Bad Request"
        res.end("Invalid JSON format");
      }
    });
  } else {
    console.log("Ignoring invalid request");
    res.code = "4.04"; // Kode untuk "Not Found"
    res.end("Not Found");
  }
});

// Start server CoAP di port 5683
server.listen(() => {
  console.log("CoAP server is running on port 5683");
});
