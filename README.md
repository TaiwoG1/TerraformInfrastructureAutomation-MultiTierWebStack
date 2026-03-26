<h1>Terraform Azure Infrastructure Automation: Multi-Tier Web Stack</h1>


<h2>Description</h2>
This project demonstrates the automated deployment of a highly available, secure cloud architecture in Azure using Terraform. The infrastructure includes a load-balanced Virtual Machine Scale Set (VMSS) running Windows Server Core and a secured Azure SQL Database, all managed via modularized code. 
<br />


<h2>Architecture Highlights:</h2>

- <b2> Modular Design: Separated into networking, compute, database, and load_balancer modules for scalability.</b2>
- <b2> Remote State Management: Utilized an Azure Blob Storage backend to securely store and lock the terraform.tfstate file. </b2>
- <b2> Security: Implemented Network Security Groups (NSGs), private subnets, private access to resources and SQL Virtual Network Rules to enforce the principle of least privilege.</b2>
- <b2> High Availability: Leveraged an Azure Load Balancer with custom Health Probes (TCP 3389) and Inbound NAT Pools for administrative access.</b2>
</b2>


<h2> Directory Structure </h2>
.
├── main.tf                # Root module calling all sub-modules                                                            
├── variables.tf           # Global variable definitions
├── terraform.tfvars       # Variable assignments (Subscription IDs, Credentials)
├── backend.tf             # Remote state configuration for sending state files to Azure Blob
└── modules/
    ├── networking/        # VNet, Subnets, NSGs, and Associations
    ├── compute/           # Windows VMSS, OS Disk, and Image Gallery configs
    ├── load_balancer/     # Public IP, LB Rules, Probes, and NAT Pools
    └── database/          # MSSQL Server, Database, and VNet Rules
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

- <b2>Remote State Backend
This screenshot confirms the Terraform state is managed externally in an Azure Storage Container, preventing state drift and enabling team collaboration.  </b2>
- <b2>Infrastructure Topology
The following visualizer map shows the relationship between the networking components and the compute/database tiers. </b2>
- <b2>Load Balancer Validation
Proof of the Load Balancer successfully distributing traffic to the VMSS backend instances via Port 8080.</b2>
</b2>


<h2> Verification & Results </h2>

- <b2> Load Balancing: Successfully verified round-robin traffic distribution by configuring unique landing pages for vmss000002 and vmss000003. </b2>
- <b2> Database Connectivity: Validated SQL connectivity by executing SELECT @@VERSION within the Azure Query Editor, confirming a healthy link between the compute and data tiers. </b2>
</b2>


<h2> Technical Challenges & Solutions</h2>

Regional Capacity Constraints (SkuNotAvailable):
Issue: Encountered 409 Conflict errors in East US due to SKU limitations for B-Series and F-Series VMs.
Solution: Migrated the deployment to Canada Central and re-architected the configuration to use Standard_D2s_v3 instances, ensuring resource availability and performance.

Terraform State Inconsistency:
Issue: Encountered "Inconsistent Result" errors during resource creation due to API latency and provider state mismatches (azurerm v4).
Solution: Performed manual state reconciliation using Terraform import to sync existing cloud resources with the local
configuration without data loss.
<br/>

Server Core Post-Deployment Configuration:
Issue: Standard IIS deployment was not immediately reachable due to Guest OS firewall restrictions and a lack of GUI tools.
Solution: Leveraged PowerShell to remotely configure the Windows Firewall and rebind IIS to Port 8080 to align with Load Balancer health probes.
<br/>



<h2>Lessons Learned & Security Notes:</h2>

- <b2> Capacity Handling: Experienced real-world cloud constraints (SkuNotAvailable) and successfully pivoted between regions (East US to Canada Central) and SKUs (B-Series to D-Series). Also learned to use az vm list-skus to verify regional availability before committing to a Terraform plan.</b2>
- <b2> Provider Consistency: Debugged "Inconsistent Result" errors in azurerm v4.1.0 by utilizing terraform import to reconcile state. </b2>
- <b2> Security Improvement: Future iterations will move away from shared admin credentials for VM and SQL tiers, utilizing Azure Key Vault for secret rotation. </b2>
- <b2> Terraform State File: Managing an "Inconsistent Result" taught me that Terraform is only as good as its state file. Learning to use Terraform state list and Terraform import helped maintain consistent Terraform state. </b2>
- <b2> Standard vs. Basic SKUs: Discovered that Standard Load Balancer is required for modern VM Scale Sets to enable reliable Health Probes and multi-zone support. Moving away from "Basic" SKUs solved several connectivity "Time-Out" issues. </b2>
- <b2> Server Core Efficiency: Operating in a GUI-less environment (Windows Server Core) reinforced the importance of PowerShell automation. </b2>
</b2>




