class DataModel {
  final String title;
  final String imageName;
  final String author;
  final String date;
  final String context;

  DataModel(this.title, this.imageName, this.author, this.date, this.context);
}

List<DataModel> dataList = [
  DataModel(
      "Understanding Earthquake Risks",
      "assets/images/earthquake_risks.jpg",
      "Dr. Seismic Wave",
      "12.10.2024",
      "Discover the various factors that contribute to earthquake risks across different regions. Learn about seismic zones, historical data, and how modern technology helps in assessing potential dangers."
  ),
  DataModel(
      "Earthquake Preparedness 101",
      "assets/images/earthquake_preparedness.jpg",
      "Ella Quake",
      "25.12.2024",
      "A comprehensive guide on how individuals and families can prepare for an earthquake. Includes tips on emergency kits, securing your home, and developing a family communication plan."
  ),
  DataModel(
      "After the Quake: Recovery and Rebuilding",
      "assets/images/earthquake_recovery.jpg",
      "Max Resilient",
      "07.03.2025",
      "Focuses on the steps communities and individuals should take in the aftermath of an earthquake. Discusses assessment of damages, accessing aid, and strategies for rebuilding stronger."
  ),
  DataModel(
      "Innovative Building Designs for Earthquake Resistance",
      "assets/images/earthquake_resistant_buildings.jpg",
      "Isa Innovator",
      "16.05.2025",
      "Explores cutting-edge building techniques and materials designed to withstand earthquakes. Highlights examples from around the world and discusses the future of construction in seismic zones."
  ),
  DataModel(
      "Seismic Warning Systems: How They Work",
      "assets/images/seismic_warning_systems.jpg",
      "Sam Signal",
      "29.08.2025",
      "An overview of seismic warning systems, their components, and how they provide crucial seconds or minutes of warning before an earthquake hits, allowing people and systems to take preventative actions."
  ),
];
