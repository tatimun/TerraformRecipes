### Configuración General
- Trigger: Se ejecuta en la rama main.
- Pool: Utiliza una máquina virtual ubuntu-latest.
- Recursos: Repositorio como fuente de configuración de infraestructura.

### Variables
Define variables para el nombre del repositorio, usuario y email de Git, y versión de Terraform (1.9.7).

### Stages
1. ***Init*** - Inicializar Terraform
Descripción: Inicializa Terraform sin backend.
Pasos:
Instala Terraform.
Ejecuta terraform init -backend=false para inicialización sin backend.
2. **Validate** - Validación de Configuración
Descripción: Valida la configuración de Terraform.

    Pasos:

    a. Instala Terraform.

    b. Ejecuta terraform validate para asegurar que la configuración sea válida.


3. **Plan** - Generación de Plan
Descripción: Genera el plan de despliegue de Terraform y lo guarda como artefacto.

    Pasos:

    a. Instala Terraform.
  
    b. Ejecuta terraform plan -out=tfplan para generar el archivo de plan.
  
    c. Publica los artefactos de Terraform (tfplan, .terraform, .terraform.lock.hcl) para usarlos en etapas posteriores.

4. **Approval** - Aprobación Manual

    Descripción: Espera una aprobación manual para proceder con el despliegue.

    Pasos:

    a. Espera aprobacion
    Timeout de 60 minutos.

5. **Apply** - Aplicación de la Infraestructura
Descripción: Aplica la infraestructura basada en el plan aprobado.

Pasos:

  a. Descarga los artefactos publicados (tfplan, terraform-lock, terraform-providers).
  
  b. Ejecuta terraform apply -auto-approve tfplan para aplicar la infraestructura.
