export const gardenBedTemplates = [
  {
    id: "template-1",
    name: "Classically Arranged",
    bedSize: { bedLength: 12, bedDepth: 6 },
    placedPlants: [
      {
        id: 1,
        name: "Boxwood",
        diameter: 2,
        height: 5,
        x: 6, //length/2
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 2,
        name: "Boxwood",
        diameter: 2,
        height: 5,
        x: 8, //length/2+1*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 3,
        name: "Boxwood",
        diameter: 2,
        height: 5,
        x: 4, //length/2-1*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 4,
        name: "Boxwood",
        diameter: 2,
        height: 5,
        x: 10, //length/2+2*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 5,
        name: "Boxwood",
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
        name: "Spreading Japanese Plum Yew",
        diameter: 3,
        height: 3,
        x: 4.5, //length/2-radius (optimized for max # of widest plant to start off-center)
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 7,
        name: "Spreading Japanese Plum Yew",
        diameter: 3,
        height: 3,
        x: 7.5, //length/2+radius
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 8,
        name: "Spreading Japanese Plum Yew",
        diameter: 3,
        height: 3,
        x: 10.5, //length/2+radius+diameter
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 9,
        name: "Spreading Japanese Plum Yew",
        diameter: 3,
        height: 3,
        x: 1.5, //length/2-radius-diameter
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 10,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 1,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 11,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 2,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 12,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 3,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 12,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 4,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 13,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 5,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 14,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 6,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 15,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 7,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 16,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 8,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 17,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 9,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 18,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 10,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 19,
        name: "Japanese Painted Fern",
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
    name: "copy of Classically Arranged",
    bedSize: { bedLength: 12, bedDepth: 6 },
    placedPlants: [
      {
        id: 1,
        name: "Boxwood",
        diameter: 2,
        height: 5,
        x: 6, //length/2
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 2,
        name: "Boxwood",
        diameter: 2,
        height: 5,
        x: 8, //length/2+1*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 3,
        name: "Boxwood",
        diameter: 2,
        height: 5,
        x: 4, //length/2-1*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 4,
        name: "Boxwood",
        diameter: 2,
        height: 5,
        x: 10, //length/2+2*diameter
        y: 1, //tallest plant goes in back, so, just diameter/2
        color: "#6FC500",
        accent_color: "",
      },
      {
        id: 5,
        name: "Boxwood",
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
        name: "Spreading Japanese Plum Yew",
        diameter: 3,
        height: 3,
        x: 4.5, //length/2-radius (optimized for max # of widest plant to start off-center)
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 7,
        name: "Spreading Japanese Plum Yew",
        diameter: 3,
        height: 3,
        x: 7.5, //length/2+radius
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 8,
        name: "Spreading Japanese Plum Yew",
        diameter: 3,
        height: 3,
        x: 10.5, //length/2+radius+diameter
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 9,
        name: "Spreading Japanese Plum Yew",
        diameter: 3,
        height: 3,
        x: 1.5, //length/2-radius-diameter
        y: 3.5, // diameter of previous plant + diameter/2
        color: "#ABD726",
        accent_color: "",
      },
      {
        id: 10,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 1,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 11,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 2,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 12,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 3,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 12,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 4,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 13,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 5,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 14,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 6,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 15,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 7,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 16,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 8,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 17,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 9,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 18,
        name: "Japanese Painted Fern",
        diameter: 1,
        height: 1,
        x: 10,
        y: 5.5, //sum of diameter of previous plants + diameter/2
        accent_color: "#E7FF9E",
        color: "#683A45",
      },
      {
        id: 19,
        name: "Japanese Painted Fern",
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
];
