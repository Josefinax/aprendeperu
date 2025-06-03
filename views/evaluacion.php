<?php
// Conexión a la base de datos
$conexion = new mysqli("localhost", "root", "", "aprende_peru_db");
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// Recibir datos del formulario
$apellidos = $_POST['apellidos'] ?? '';
$nombres = $_POST['nombres'] ?? '';
$dni = $_POST['dni'] ?? '';
$telefono = $_POST['telefono'] ?? '';
$email = $_POST['email'] ?? '';

// Guardar nueva pregunta si se envió el formulario modal
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['pregunta']) && isset($_POST['idevaluacion'])) {
    $pregunta = $conexion->real_escape_string($_POST['pregunta']);
    $puntaje = 4;
    $rutaimagen = '';
    $idevaluacion = (int) $_POST['idevaluacion'];
    $conexion->query("INSERT INTO preguntas (idevaluacion, pregunta, puntaje, rutaimagen) VALUES ($idevaluacion, '$pregunta', $puntaje, '$rutaimagen')");
}

// Obtener preguntas
$resultado = $conexion->query("SELECT idpregunta, pregunta FROM preguntas");

?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Preguntas del Examen</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />
  <style>
    body {
      background: linear-gradient(to right, #e0eafc, #cfdef3);
      min-height: 100vh;
      padding-bottom: 80px;
    }
    .card-question:hover {
      transform: scale(1.02);
      transition: all 0.3s ease;
    }
    .btn-float {
      position: fixed;
      bottom: 30px;
      right: 30px;
      width: 60px;
      height: 60px;
      border-radius: 50%;
      font-size: 28px;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
      z-index: 1000;
    }
  </style>
</head>
<body>

<div class="container py-5">
  <div class="mb-4 text-center">
    <h2 class="text-primary fw-bold">Bienvenido <?= htmlspecialchars($nombres . " " . $apellidos) ?></h2>
    <p class="text-muted">DNI: <?= htmlspecialchars($dni) ?> | Teléfono: <?= htmlspecialchars($telefono) ?> | Email: <?= htmlspecialchars($email) ?></p>
  </div>

  <h3 class="mb-3">📝 Lista de Preguntas</h3>
  <div class="row row-cols-1 row-cols-md-2 g-4 mb-5">
    <?php while ($fila = $resultado->fetch_assoc()): ?>
      <div class="col">
        <a href="pregunta.php?id=<?= $fila['idpregunta'] ?>" class="text-decoration-none text-dark">
          <div class="card shadow-sm card-question h-100">
            <div class="card-body">
              <h5 class="card-title"><i class="bi bi-question-circle-fill text-primary"></i> <?= htmlspecialchars($fila['pregunta']) ?></h5>
              <p class="card-text text-muted small">Haz clic para ver opciones</p>
            </div>
          </div>
        </a>
      </div>
    <?php endwhile; ?>
  </div>
</div>

<!-- Botón flotante para abrir modal -->
<button type="button" class="btn btn-primary btn-float" data-bs-toggle="modal" data-bs-target="#modalPregunta" aria-label="Agregar nueva pregunta">
  <i class="bi bi-plus-lg"></i>
</button>

<!-- Modal para agregar nueva pregunta -->
<div class="modal fade" id="modalPregunta" tabindex="-1" aria-labelledby="modalPreguntaLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form method="POST" class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalPreguntaLabel"><i class="bi bi-plus-circle-fill text-success"></i> Nueva Pregunta</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label for="pregunta" class="form-label">Texto de la pregunta</label>
          <textarea class="form-control" id="pregunta" name="pregunta" rows="3" required></textarea>
        </div>
        <div class="mb-3">
          <label for="idevaluacion" class="form-label">ID de Evaluación</label>
          <input type="number" class="form-control" id="idevaluacion" name="idevaluacion" required>
        </div>
        <!-- Aquí podrías agregar campos ocultos si quieres enviar datos del usuario a la tabla preguntas -->
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-success w-100">Guardar Pregunta</button>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
