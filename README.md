<h1>Terraform Azure Infrastructure Automation: Multi-Tier Web Stack</h1>


<h2>Description</h2>
This project demonstrates the automated deployment of a highly available, secure cloud architecture in Azure using Terraform. The infrastructure includes a load-balanced Virtual Machine Scale Set (VMSS) running Windows Server Core and a secured Azure SQL Database, all managed via modularized code. 
<br />


<h2>Architecture Highlights:</h2>

- <b2> Modular Design: Separated into networking, compute, load_balancer and database modules for scalability, reusability and maintenance purposes.</b2>
- <b2> Remote State Management: Utilized an Azure Blob Storage backend to securely store and lock the terraform.tfstate file to ensure consistency. </b2>
- <b2> Security: Implemented Network Security Groups (NSGs), private subnets, private access to resources and SQL Virtual Network Rules to enforce the principle of least privilege.</b2>
- <b2> High Availability: Leveraged an Azure Load Balancer with custom Health Probes (TCP 3389) and Inbound NAT Pools for administrative access.</b2>
</b2>


<h2> Directory Structure </h2>
&nbsp;. <br/>
├── main.tf                # Root module calling all sub-modules <br/>
├── variables.tf           # Global variable definitions <br/>
├── terraform.tfvars       # Variable assignments (Subscription IDs, Credentials) <br/>
├── backend.tf             # Remote state configuration for sending state files to Azure Blob <br/>
├── providers.tf           # Terraform providers (plugins) configuration <br/>
└── modules/ <br/>
&emsp;&emsp;&emsp;    ├── networking/        # VNet, Subnets, NSGs, and Associations <br/>
&emsp;&emsp;&emsp;    ├── compute/           # Windows VMSS, NIC, OS Disk, and Image References <br/>
&emsp;&emsp;&emsp;    ├── load_balancer/     # Public IP, LB Rules, Probes, and NAT Pools <br/>
&emsp;&emsp;&emsp;    └── database/          # MSSQL Server, Database, and VNet Rules <br/>
<br />


<h2> Modules & Resources Managed </h2>

- <b2> Networking: Virtual Network, Subnets, NSG Rules (Port 80, 3389, 8080)</b2>
- <b2> Compute: Windows Server 2016 Virtual Machine Scale Set (Standard_D2s_v3), Admin Provisioning</b2>
- <b2> Load Balancer: Standard SKU Load Balancer, Health Probes, Inbound NAT (Ports 50000+)</b2>
- <b2> Database: Azure SQL Server, Database, VNet Service Endpoints</b2>
</b2>



<h2> Terraform Lifecycle Workflow</h2>

To demonstrate best practices in Terraform Infrastructure as Code (IaC), the following workflow was strictly followed:
<br />
- <b2> terraform fmt: Utilized to ensure canonical formatting and style consistency across all configuration files.</b2>
- <b2> terraform init: Initialized the working directory and configured the remote Azure RM backend.</b2>
- <b2> terraform plan: Generated a speculative execution plan to verify resource counts and configurations before deployment.</b2>
- <b2> terraform apply -auto-approve: Leveraged for deployment automation, reducing manual intervention while maintaining state integrity.</b2>
- <b2> terraform state list: Used post-deployment to audit and verify the mapping of all managed resources.</b2>
- <b2> terraform state show <resource>: Performed deep-dive inspections into specific resource attributes (like the Load Balancer's Private IP) for troubleshooting.</b2>
- <b2> terraform plan -destroy: Generated a pre-destruction plan to ensure only the intended resources were targeted.</b2>
- <b2> terraform destroy: Successfully decommissioned the entire stack to ensure zero ongoing costs.</b2>
</b2>



<h2>Deployment Evidence: </h2>

- <b2>**Remote State Backend:** <br>
The terraform state was managed externally in an Azure Storage Container, preventing state drift and enabling team collaboration in enterprise environments.  </b2>
    <p align="center">
    <img width="1365" height="396" alt="terraform_backend_storage_tfstate_file" src="https://github.com/user-attachments/assets/7a9c9023-2635-4629-acbf-7540cf4ae906" />
      <br />
    Azure Storage Blob Container storing Initial Terraform state file
    <br />
  </p>
    <p align="center">
    <img width="1365" height="402" alt="terraform_backend_storage_tfstate_file2" src="https://github.com/user-attachments/assets/a9981fd8-98b2-4b8d-aa78-d510300cd1e3" />
      <br />
    Azure Storage Blob Container storing Final Terraform state file
    <br />
  </p>
<br />


- <b2>**Infrastructure Topology:** <br>
The image shows the Resource group containing the project resources and the visualizer map showing the relationship between the networking, load balancer, compute and database components. </b2>
    <p align="center">
    <img width="1351" height="533" alt="terraform_6_all_resources" src="https://github.com/user-attachments/assets/3f87b16e-3b8c-4355-8919-05460ec388bd" />
      <br />
    Resource Group showing the automated resource deployments
    <br />
  </p>
    <p align="center">
    <img width="1365" height="691" alt="terraform_resource_visualizer" src="https://github.com/user-attachments/assets/8372bb4a-da2d-4f03-940f-9d96f426e788" />
      <br />
    Resource Visualizer Topology map showing the relationship between Project component resources
    <br />
  </p>  
<br />


- <b2> **Compute:** <br>
VMSS <b2/>
    <p align="center">
    <img width="1351" height="708" alt="terraform_4_vmss1" src="https://github.com/user-attachments/assets/53aa23a8-ed3a-48cd-8423-c437eb36db30" />
    <br />
  </p>
    <p align="center">
    <img width="1352" height="752" alt="terraform_5_vmss2" src="https://github.com/user-attachments/assets/1568dc92-8a9a-4ef5-822e-8a5f960e7395" />
      <br />
    Virtual Machine Scale Set Overview for 2 Windows Server Machine instances
    <br />
  </p>  
    <p align="center">
    <img width="1365" height="708" alt="terraform_14_rdp_windows_servers_both_instances" src="https://github.com/user-attachments/assets/5140512b-de12-4b70-b55f-a76b3dca9832" />
      <br />
    Windows Server Virtual Machines
    <br />
  </p>
<br />


- <b2>**Load Balancer:** <br>
Images of the Load balancer backend pools, Load balancing rule, vm instances health status and Load Balancer successful distribution of traffic to the VMSS backend instances via Port 8080.</b2>
    <p align="center">
    <img width="1365" height="567" alt="terraform_9_lb_backendpools" src="https://github.com/user-attachments/assets/870226b6-8eee-46ec-b67d-7e1a24d0f5ad" />
      <br />
    Load Balancer Backend Pool
    <br />
  </p>
    <p align="center">
    <img width="1365" height="753" alt="terraform_7_2_instances_vmss_healthy" src="https://github.com/user-attachments/assets/a2b1852a-ce24-4fca-9cdf-ea6db4aa94b8" />
      <br />
    Load Balancing Rule and Backend Virtual Machine Instances health status
    <br />
  </p>  
    <p align="center">
    <img width="1365" height="715" alt="terraform_8_load_balanced_web_servers" src="https://github.com/user-attachments/assets/e128989e-739f-4ef9-bed2-e42356583ac6" />
      <br />
    Load Balancer Traffic Distribution to Virtual Machine Backend Pool
    <br />
  </p>
<br /> 


- <b2> **Database:** <br>
SQL Server and Database</b2>
    <p align="center">
    <img width="1365" height="705" alt="terraform_10_sql_database" src="https://github.com/user-attachments/assets/f57505fd-d35d-47e1-92e9-8785903fefb7" />
      <br />
    SQL Database Overview
    <br />
  </p>
    <p align="center">
    <img width="1365" height="748" alt="terraform_11_login_to_sql_database" src="https://github.com/user-attachments/assets/cea749fb-69e9-4803-8c5c-212f2a2ad84e" />
      <br />
    DB Query Editor Authentication
    <br />
  </p>  
    <p align="center">
    <img width="1365" height="629" alt="terraform_12_login_successful_to_sql_database" src="https://github.com/user-attachments/assets/816000a7-5d7b-494f-a7f4-70eeff6f724b" />
      <br />
    DB Query Editor Successful Authentication
    <br />
  </p>
    <p align="center">
    <img width="1365" height="749" alt="terraform_13_running_sql_command" src="https://github.com/user-attachments/assets/340a295b-ae0a-4c8a-8c4d-7bb62fb2d70b" />
      <br />
    DB Query Editor Sample Query
    <br />
  </p>

</b2>



<h2> Verification & Results </h2>

- <b2> Load Balancing: Successfully verified round-robin traffic distribution by configuring unique landing pages for vmss000002 and vmss000003. </b2>
- <b2> Database Connectivity: Validated SQL connectivity by executing SELECT @@VERSION within the Azure Query Editor to confirm a healthy link between the compute and data tiers. </b2>
</b2>


<h2> Technical Challenges & Solutions</h2>

**Regional Capacity Constraints (SkuNotAvailable):** <br>
Challenge: Encountered Conflict errors in Initial Deployment Region due to SKU limitations for B-Series and F-Series VMs.<br>
Solution: Migrated the deployment to a secondary region location and re-architected the configuration to use Standard_D2s_v3 instances, ensuring resource availability and performance.

**Terraform State Inconsistency:** <br>
Challenge: Encountered "Inconsistent Result" errors during resource creation due to API latency and provider state mismatches (azurerm v4).<br>
Solution: Performed manual state reconciliation using "Terraform import" to correlate state and sync existing cloud resources with the local configuration without data loss.
<br/>

**Server Core Post-Deployment Configuration:** <br>
Challenge: Standard IIS deployment was not immediately reachable due to Guest OS firewall restrictions and a lack of GUI tools.<br>
Solution: Leveraged PowerShell to remotely configure the Windows Firewall and rebind IIS to Port 8080 to align with Load Balancer health probes.
<br/>



<h2>Lessons Learned & Security Notes:</h2>

- <b2> Capacity Handling: Experienced real-world cloud constraints (SkuNotAvailable) and successfully pivoted between regions and SKUs (B-Series to D-Series). Also learned to use az vm list-skus in the planning and architecting stage to verify regional availability before committing to a Terraform plan.</b2>
- <b2> Provider Consistency: Debugged "Inconsistent Result" errors in azurerm v4.1.0 by utilizing terraform import to reconcile state. </b2>
- <b2> Security Improvement: Future iterations should move away from shared admin credentials for deployed resources (VM and SQL tiers), utilizing Azure Key Vault for secret rotation. </b2>
- <b2> Terraform State File: Managing an "Inconsistent Result" demonstrated that Terraform is only as good as its state file. Learning to use Terraform state list and Terraform import helped maintain consistent Terraform state. </b2>
- <b2> Standard vs. Basic SKUs: Standard Load Balancer is required for modern VM Scale Sets to enable reliable Health Probes and multi-zone support. Moving away from Basic SKUs solved several connectivity Time-Out issues. </b2>
- <b2> Server Core Efficiency: Operating in a GUI-less environment (Windows Server Core) reinforced the importance of PowerShell automation. </b2>
</b2>




