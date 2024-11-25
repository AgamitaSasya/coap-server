//Hnadler index
module.exports.index = (req, res) => {
  // Query untuk mengambil data terakhir dari tabel dht yang tidak bernilai NULL
  const dhtSql = `
          SELECT * FROM dht 
          WHERE temperature IS NOT NULL AND humidity IS NOT NULL
          ORDER BY created_at DESC
          LIMIT 1
        `;

  // Query untuk mengambil data terakhir dari tabel node_send_logs untuk setiap node_id yang unik
  const inaSql = `
        SELECT n.node_id, n.created_at, i.current, i.voltage, i.power, i.power_consumption
        FROM node_send_logs n
        INNER JOIN (
            SELECT node_id, MAX(created_at) AS latest
            FROM node_send_logs
            WHERE node_id IS NOT NULL
            GROUP BY node_id
        ) latest_logs ON n.node_id = latest_logs.node_id AND n.created_at = latest_logs.latest
        LEFT JOIN ina i ON n.id = i.log_id
       
`;

  const soilSql = `
    SELECT s.id, s.log_id, s.sensor_order, s.moisture, s.created_at
    FROM soil_moisture s
    INNER JOIN (
        SELECT sensor_order, MAX(created_at) AS latest
        FROM soil_moisture
        GROUP BY sensor_order
    ) latest_logs ON s.sensor_order = latest_logs.sensor_order AND s.created_at = latest_logs.latest
    ORDER BY s.sensor_order
`;

  // Jalankan query untuk data dht
  req.db.query(dhtSql, (err, dhtResults) => {
    if (err) {
      console.error("Error retrieving data from dht:", err);
      return res.status(500).json({ error: "Database error" });
    }

    // Jalankan query untuk data ina
    req.db.query(inaSql, (err, inaResults) => {
      if (err) {
        console.error("Error retrieving data from ina:", err);
        return res.status(500).json({ error: "Database error" });
      }

      // Jalankan query untuk data soil
      req.db.query(soilSql, (err, soilResults) => {
        if (err) {
          console.error("Error retrieving data from soil:", err);
          return res.status(500).json({ error: "Database error" });
        }

        // Kirim data ke index.ejs
        res.render("index", {
          dhtData: dhtResults[0] || null,
          inaData: inaResults,
          soilData: soilResults,
        });
      });
    });
  });
};

// Handler untuk halaman power consumption
module.exports.powerConsumption = (req, res) => {
  const powerSql = `
    SELECT n.node_id, n.created_at, i.power_consumption 
    FROM node_send_logs n 
    INNER JOIN ina i ON n.id = i.log_id 
    WHERE n.node_id IN (1,2,3,4,5,6)
    AND i.power_consumption IS NOT NULL 
    ORDER BY n.created_at ASC
    `;

  req.db.query(powerSql, (err, results) => {
    if (err) {
      console.error("Error retrieving power consumption data:", err);
      return res.status(500).json({ error: "Database error" });
    }

    res.render("powerConsumption", {
      powerData: results,
    });
  });
};

// Handler untuk halaman delay
module.exports.delay = (req, res) => {
  const delaySql = `
    SELECT node_id, created_at, delay
    FROM node_send_logs 
    WHERE node_id IN (1,2,3,4,5,6)
    AND delay IS NOT NULL
    ORDER BY created_at ASC
  `;

  req.db.query(delaySql, (err, results) => {
    if (err) {
      console.error("Error retrieving node delay data:", err);
      return res.status(500).json({ error: "Database error" });
    }

    res.render("delay", {
      delayData: results,
    });
  });
};

// Handler untuk halaman throughput
module.exports.throughput = (req, res) => {
  const throughputSql = `
    SELECT node_id, created_at, throughput
    FROM node_send_logs 
    WHERE node_id IN (1,2,3,4,5,6)
    AND throughput IS NOT NULL
    ORDER BY created_at ASC
  `;

  req.db.query(throughputSql, (err, results) => {
    if (err) {
      console.error("Error retrieving node throughput data:", err);
      return res.status(500).json({ error: "Database error" });
    }

    res.render("throughput", {
      throughputData: results,
    });
  });
};

// Controller untuk payload_size
module.exports.payloadSize = (req, res) => {
  const payloadSql = `
      SELECT 
          node_id, 
          created_at, 
          payload_size 
      FROM node_send_logs 
      WHERE node_id IN (1,2,3,4,5,6) 
      AND payload_size IS NOT NULL 
      ORDER BY created_at ASC
  `;

  req.db.query(payloadSql, (err, results) => {
    if (err) {
      console.error("Error retrieving payload size data:", err);
      return res.status(500).json({ error: "Database error" });
    }

    res.render("payloadSize", {
      payloadData: results,
    });
  });
};

// controllers/logController.js
exports.getLogData = (req, res) => {
  const logSql = `
    SELECT 
      ROW_NUMBER() OVER (ORDER BY nsl.created_at DESC) as no,
      CONCAT('Node ', nsl.node_id) as nama,
      CONCAT(
        COALESCE(CONCAT('Arus: ', ROUND(i.current, 2), 'A'), ''),
        CASE WHEN i.current IS NOT NULL THEN ', ' ELSE '' END,
        COALESCE(CONCAT('Tegangan: ', ROUND(i.voltage, 2), 'V'), ''),
        CASE WHEN i.voltage IS NOT NULL THEN ', ' ELSE '' END,
        COALESCE(CONCAT('Daya: ', ROUND(i.power, 2), 'W'), ''),
        CASE WHEN i.power IS NOT NULL THEN ', ' ELSE '' END,
        COALESCE(CONCAT('Suhu: ', ROUND(d.temperature, 2), '°C'), ''),
        CASE WHEN d.temperature IS NOT NULL THEN ', ' ELSE '' END,
        COALESCE(CONCAT('Kelembaban Udara: ', ROUND(d.humidity, 2), '%'), ''),
        CASE WHEN d.humidity IS NOT NULL AND 
          (SELECT COUNT(*) FROM soil_moisture sm2 
           WHERE ABS(TIMESTAMPDIFF(SECOND, nsl.created_at, sm2.created_at)) <= 30) > 0 
        THEN ', ' ELSE '' END,
        CASE 
          WHEN (SELECT COUNT(*) FROM soil_moisture sm2 
                WHERE ABS(TIMESTAMPDIFF(SECOND, nsl.created_at, sm2.created_at)) <= 30) > 0 
          THEN GROUP_CONCAT(
            CONCAT('Kelembaban Tanah ', sm.sensor_order, ': ', ROUND(sm.moisture, 2), '%')
            ORDER BY sm.sensor_order
            SEPARATOR ', '
          )
          ELSE ''
        END
      ) as data_sensor,
      CONCAT(nsl.delay, 'ms') as delay,
      CONCAT(nsl.payload_size, 'kbps') as ukuran_paket,
      CONCAT(nsl.throughput, 'bps') as throughput,
      DATE_FORMAT(nsl.created_at, '%Y/%d/%m') as start_date
    FROM node_send_logs nsl
    LEFT JOIN ina i ON nsl.id = i.log_id
    LEFT JOIN dht d ON ABS(TIMESTAMPDIFF(SECOND, nsl.created_at, d.created_at)) <= 30
    LEFT JOIN soil_moisture sm ON ABS(TIMESTAMPDIFF(SECOND, nsl.created_at, sm.created_at)) <= 30
    WHERE nsl.node_id IS NOT NULL
    GROUP BY nsl.id, nsl.node_id, nsl.delay, nsl.payload_size, nsl.throughput, 
             nsl.created_at, i.current, i.voltage, i.power,
             d.temperature, d.humidity
    ORDER BY nsl.created_at DESC
    LIMIT 100
  `;

  req.db.query(logSql, (err, results) => {
    if (err) {
      console.error("Error retrieving log data:", err);
      return res.status(500).json({
        error: "Terjadi kesalahan saat mengambil data log",
      });
    }

    res.render("logs", {
      logs: results,
    });
  });
};
