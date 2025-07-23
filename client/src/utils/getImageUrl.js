//this fuction should not be used.  Waiting to remove entirely until image routes are completely figured out

// export function getImageUrl(plantName, options = {}) {
//   const { cloudName = "dprixcop0", folder = "plants" } = options;

//   // Convert plant name to kebab-case
//   const kebabName = plantName
//     .toLowerCase()
//     .replace(/[^a-z0-9\s]/g, "") // remove special chars
//     .trim()
//     .replace(/\s+/g, "-"); // replace spaces with dash

//   return `https://res.cloudinary.com/${cloudName}/image/upload/f_auto/${folder}/${kebabName}`;
// }
