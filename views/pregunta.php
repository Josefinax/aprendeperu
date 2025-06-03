<?php
if (!isset($_GET['id'])) {
    die("ID de pregunta no proporcionado.");
}

$conexion = new mysqli("localhost", "root", "", "aprende_peru_db");
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

$idpregunta = intval($_GET['id']);

// Obtener pregunta
$preguntaQuery = $conexion->query("SELECT pregunta FROM preguntas WHERE idpregunta = $idpregunta");
$preguntaData = $preguntaQuery->fetch_assoc();

// Obtener alternativas
$alternativasQuery = $conexion->query("SELECT texto, escorrecta FROM alternativas WHERE idpregunta = $idpregunta");
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Pregunta</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
  <h3 class="mb-4 text-success"><?= htmlspecialchars($preguntaData['pregunta']) ?></h3>

  <div class="list-group">
    <?php while ($alt = $alternativasQuery->fetch_assoc()): ?>
      <div class="list-group-item d-flex justify-content-between align-items-center">
        <?= htmlspecialchars($alt['texto']) ?>
        <?php if ($alt['escorrecta']): ?>
          <span class="badge bg-success">Correcta</span>
        <?php endif; ?>
      </div>
    <?php endwhile; ?>
  </div>

  <a href="evaluacion.php" class="btn btn-secondary mt-4">← Volver a preguntas</a>
</div>

</body>
</html>
