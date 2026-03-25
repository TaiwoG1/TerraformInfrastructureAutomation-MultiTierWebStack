<h1>Terraform Azure Infrastructure Automation: Multi-Tier Web Stack</h1>


<h2>Description</h2>
This project demonstrates the automated deployment of a highly available, secure cloud architecture in Azure using Terraform. The infrastructure includes a load-balanced Virtual Machine Scale Set (VMSS) running Windows Server Core and a secured Azure SQL Database, all managed via modularized code. 
<br />
<br />
<h2>Architecture Highlights:</h2>

- <b2> Modular Design: Separated into networking, compute, database, and load_balancer modules for scalability.</b2>
- <b2> Remote State Management: Utilizes an Azure Blob Storage backend to securely store and lock the terraform.tfstate file. </b2>
- <b2> Security First: Implements Network Security Groups (NSGs), private subnets, and SQL Virtual Network Rules to enforce the principle of least privilege.</b2>
- <b2> High Availability: Leverages an Azure Load Balancer with custom Health Probes (TCP 3389) and Inbound NAT Pools for administrative access.</b2>
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
<br />

<h2> Modules	& Resources Managed </h2>

- <b2> Networking	Virtual Network, Subnets, NSG Rules (Port 80, 3389, 8080)</b2>
- <b2> Compute	Windows Server 2016 VMSS (Standard_D2s_v3), Admin Provisioning</b2>
- <b2> Load Balancer	Standard SKU LB, Health Probes, Inbound NAT (Ports 50000+)</b2>
- <b2> Database	Azure SQL Server, S0 Database, VNet Service Endpoints</b2>
</b2>

<h2>Deployment Evidence: </h2>

- <b2> 1. Remote State Backend
This screenshot confirms the Terraform state is managed externally in an Azure Storage Container, preventing state drift and enabling team collaboration.  </b2>
- <b2> 2. Infrastructure Topology
The following visualizer map shows the relationship between the networking components and the compute/database tiers. </b2>
- <b2> 3. Load Balancer Validation
Proof of the Load Balancer successfully distributing traffic to the VMSS backend instances via Port 8080.</b2>
</b2>


<h2>Lessons Learned & Security Notes:</h2>

- <b2> Capacity Handling: Experienced real-world cloud constraints (SkuNotAvailable) and successfully pivoted between regions (East US to Canada Central) and SKUs (B-Series to D-Series).</b2>
- <b2> Provider Consistency: Debugged "Inconsistent Result" errors in azurerm v4.1.0 by utilizing terraform import to reconcile state. </b2>
- <b2> Security Improvement: Future iterations will move away from shared admin credentials for VM and SQL tiers, utilizing Azure Key Vault for secret rotation. </b2>
</b2>




