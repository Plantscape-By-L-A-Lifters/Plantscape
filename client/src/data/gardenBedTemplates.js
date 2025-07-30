//ideally the garden bed templates would be part of the generateSeed.js function.. for the sake of time, im pulling the seeded ids from that file and hard-coding them below.

const DesignsStyleIds = [
  {
    designStyleName: "classical",
    designStyleId: "5ef09090-a44d-4067-bf69-474d2c639d6a",
  },
  {
    designStyleName: "modern minimalism",
    designStyleId: "a4e1b58e-f2d6-423f-a332-2965ddf0f6bc",
  },
  {
    designStyleName: "modern lush",
    designStyleId: "cb520214-6747-4ce4-81d3-305a13c780aa",
  },
  {
    designStyleName: "cottage",
    designStyleId: "84d03225-a2f4-411b-9b19-cd5e31f49bed",
  },
  {
    designStyleName: "naturalistic",
    designStyleId: "8ddbc1dc-bbd3-41b7-929f-46db20f1d53c",
  },
  {
    designStyleName: "naturalistic woodland",
    designStyleId: "853d88c2-ea4f-4fb9-b4ef-f7854d871337",
  },
  {
    designStyleName: "naturalistic prairie",
    designStyleId: "0a1b7ed3-052e-4514-977a-28da75117f42",
  },
];

const templatePlacedPlants = [];

// Helper function to get design ID by name
const getDesignId = (name) => {
  const design = DesignsStyleIds.find(
    (d) => d.designStyleName === name.toLowerCase()
  );
  return design ? design.designStyleId : null; // Return null or throw error if not found
};

export const gardenBedTemplates = [
  {
    id: "template-1",
    name: "Classically Arranged",
    designStyleId: getDesignId("classical"), //temporary solution to above
    bedSize: { bedWidth: 12, bedDepth: 6 },
    image_url:
      "https://ecogardenconstruct.com/wp-content/uploads/2023/01/amenajare-peisagistica-bg.jpg",
    placedPlants: [
      {
        id: 1,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 6, //length/2
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 2,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 8, //length/2+1*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 3,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 4, //length/2-1*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 4,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 10, //length/2+2*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 5,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 2, //length/2-2*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
      },
      //next row loops through next tallest plant
      {
        id: 6,
        name: "spreading plum yew",
        diameter: 3,
        height: 3,
        x: 4.5, //length/2-radius (optimized for max # of widest plant to start off-center)
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 7,
        name: "spreading plum yew",
        diameter: 3,
        height: 3,
        x: 7.5, //length/2+radius
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 8,
        name: "spreading plum yew",
        diameter: 3,
        height: 3,
        x: 10.5, //length/2+radius+diameter
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 9,
        name: "spreading plum yew",
        diameter: 3,
        height: 3,
        x: 1.5, //length/2-radius-diameter
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 10,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 1,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 11,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 2,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 12,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 3,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 12,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 4,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 13,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 5,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 14,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 6,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 15,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 7,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 16,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 8,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 17,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 9,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 18,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 10,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 19,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 11,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
    ],
    isTemplate: true,
  },
  {
    id: "template-2",
    name: "Prairie Paradise",
    designStyleId: getDesignId("naturalistic prairie"),
    bedSize: { bedWidth: 12, bedDepth: 6 },
    image_url:
      "https://www.epicgardening.com/wp-content/uploads/2023/09/Herb-garden-with-ornamental-grasses-and-herbs-in-autumn-1200x667.jpg",
    placedPlants: [
      {
        id: 1,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 6, //length/2
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 2,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 8, //length/2+1*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 3,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 4, //length/2-1*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 4,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 10, //length/2+2*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 5,
        name: "boxwood",
        diameter: 2,
        height: 5,
        x: 2, //length/2-2*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      //next row loops through next tallest plant
      {
        id: 6,
        name: "spreading plum yew",
        diameter: 3,
        height: 3,
        x: 4.5, //length/2-radius (optimized for max # of widest plant to start off-center)
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 7,
        name: "spreading plum yew",
        diameter: 3,
        height: 3,
        x: 7.5, //length/2+radius
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 8,
        name: "spreading plum yew",
        diameter: 3,
        height: 3,
        x: 10.5, //length/2+radius+diameter
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 9,
        name: "spreading plum yew",
        diameter: 3,
        height: 3,
        x: 1.5, //length/2-radius-diameter
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 10,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 1,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 11,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 2,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 12,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 3,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 12,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 4,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 13,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 5,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 14,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 6,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 15,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 7,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 16,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 8,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 17,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 9,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 18,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 10,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 19,
        name: "japanese painted fern",
        diameter: 1,
        height: 1,
        x: 11,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
    ],
    isTemplate: true,
  },
  {
    id: "template-3",
    name: "Native Woodland",
    designStyleId: getDesignId("naturalistic woodland"),
    bedSize: { bedWidth: 12, bedDepth: 6 },
    image_url:
      "https://hips.hearstapps.com/hmg-prod/images/woodland-garden-ideas-ground-1618242057.jpg?crop=1xw:1xh;center,top&resize=980:*",
  },
  {
    id: "template-4",
    name: "Cottagecore",
    designStyleId: getDesignId("cottage"),
    bedSize: { bedWidth: 12, bedDepth: 6 },
    image_url:
      "https://cdn.shopify.com/s/files/1/0593/3265/7306/files/01-pollinator-flower-bed.png?v=1727708811",
  },
  {
    id: "template-5",
    name: "Modern Minimalism",
    designStyleId: getDesignId("modern minimalism"),
    bedSize: { bedWidth: 8, bedDepth: 5 },
    image_url:
      "https://www.almanac.com/sites/default/files/users/The%20Editors/rock-garden-house-shutterstock_1948570909.jpg",
  },
  {
    id: "template-6",
    name: "Modern Lush",
    designStyleId: getDesignId("modern lush"),
    bedSize: { bedWidth: 15, bedDepth: 10 },
    image_url:
      "https://www.monrovia.com/media/amasty/blog/1024x577_Robin_Parsons_garden_designer_-_West_Seattle_project_2514PM_copy.jpg",
  },
];
