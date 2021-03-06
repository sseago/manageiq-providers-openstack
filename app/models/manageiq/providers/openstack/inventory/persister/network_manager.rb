class ManageIQ::Providers::Openstack::Inventory::Persister::NetworkManager < ManagerRefresh::Inventory::Persister
  def cloud
    ManageIQ::Providers::Openstack::InventoryCollectionDefault::CloudManager
  end

  def network
    ManageIQ::Providers::Openstack::InventoryCollectionDefault::NetworkManager
  end

  def initialize_inventory_collections
    add_inventory_collections(
      network,
      %i(
        cloud_networks
        cloud_subnets
        floating_ips
        network_ports
        network_routers
        security_groups
      ),
      :builder_params => {:ext_management_system => manager}
    )

    add_inventory_collections(
      network,
      %i(
        cloud_subnet_network_ports
        firewall_rules
      )
    )

    add_inventory_collections(
      cloud,
      %i(
        vms
        orchestration_stacks
        availability_zones
        cloud_tenants
      ),
      :parent   => manager.parent_manager,
      :strategy => :local_db_cache_all
    )
  end
end
