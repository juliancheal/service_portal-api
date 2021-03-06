class ServicePlans < TopologyServiceApi
  def process
    result = api_instance.list_service_offering_service_plans(service_offering_ref)
    filter_result(result)
  rescue StandardError => e
    Rails.logger.error("Service Plans #{e.message}")
    raise
  end

  def service_offering_ref
    PortfolioItem.find(params['portfolio_item_id']).service_offering_ref
  end

  def filter_result(result)
    result.each_with_object([]) do |obj, array|
      array << {
        'name'               => obj.name,
        'description'        => obj.description,
        'id'                 => obj.id,
        'create_json_schema' => obj.create_json_schema
      }
    end
  end
end
