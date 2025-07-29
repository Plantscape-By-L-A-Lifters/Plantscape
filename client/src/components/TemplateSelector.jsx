import "./TemplateSelector.css";

// TemplateSelector component: Displays available templates and allows selection
// Props:
// - templates: Array of template objects (from GardenBedContext.templateBeds)
// - onSelectTemplate: Callback function (template) => void, called when a template is selected
// - selectedTemplateId: The ID of the currently selected template (for highlighting)

export function TemplateSelector({
  templates,
  onSelectTemplate,
  selectedTemplateId,
}) {
  if (!templates || templates.length === 0) {
    return <p>No templates available.</p>;
  }

  return (
    <div className="template-selector-grid">
      {templates.map((template) => (
        <div
          key={template.id}
          onClick={() => onSelectTemplate(template)}
          className={`template-card ${
            selectedTemplateId === template.id ? "selected" : ""
          }`}
        >
          <h3>{template.name}</h3>
          {/* <p>
            Size: {template.bedLength}ft x {template.bedDepth}ft
          </p> */}
          <p>Design Style: {template.designStyleName}</p>
          {/* You can add a small image preview here if your templates have image_url */}
          {template.image_url && (
            <img src={template.image_url} alt={template.name} />
          )}
        </div>
      ))}
    </div>
  );
}
