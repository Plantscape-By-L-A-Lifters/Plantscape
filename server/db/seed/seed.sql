-- SQL SEED File generated on 2025-07-25T21:42:50.398Z


DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS plant_layout;
DROP TABLE IF EXISTS layouts;
DROP TABLE IF EXISTS favorite_plants;
DROP TABLE IF EXISTS plant_Design_Types;
DROP TABLE IF EXISTS fave_design;
DROP TABLE IF EXISTS plants;
DROP TABLE IF EXISTS designs;
DROP TABLE IF EXISTS users;


CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users(
    id UUID PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    is_admin BOOLEAN DEFAULT false NOT NULL
);

CREATE TABLE designs(
    id UUID PRIMARY KEY,
    design_style_name VARCHAR(50) UNIQUE NOT NULL,
    design_attributes VARCHAR(255),    -- short description
    design_description TEXT,           -- long description
    design_tags TEXT                   -- tags
);

CREATE TABLE IF NOT EXISTS plants (
    id UUID PRIMARY KEY,
    plant_name VARCHAR(255) UNIQUE NOT NULL,
    other_common_names TEXT,
    technical_name VARCHAR(255),
    growth_form VARCHAR(50),
    is_toxic BOOLEAN DEFAULT false NOT NULL,
    sun_requirements TEXT,
    height_min_ft NUMERIC(5, 2),
    height_max_ft NUMERIC(5, 2),
    width_min_ft NUMERIC(5, 2),
    width_max_ft NUMERIC(5, 2),
    seasonal_interest TEXT,
    primary_color VARCHAR(50),
    accent_color VARCHAR(50),
    image_url TEXT
);

CREATE TABLE favorite_plants(
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    plant_id UUID REFERENCES plants(id),
    CONSTRAINT user_and_plant_id UNIQUE(user_id, plant_id)
);

CREATE TABLE plant_Design_Types(
    id UUID PRIMARY KEY,
    plant_id UUID REFERENCES plants(id),
    design_id UUID REFERENCES designs(id),
    UNIQUE (plant_id, design_id)
);


CREATE TABLE projects(
    id UUID PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    user_id UUID REFERENCES users(id)
);

CREATE TABLE layouts(
    id UUID PRIMARY KEY,
    layout_name varchar(100) NOT NULL,
    bed_length INTEGER NOT NULL,
    bed_depth INTEGER NOT NULL,
    design_type UUID REFERENCES designs(id),
    projects_id UUID REFERENCES projects(id)
);

CREATE TABLE plant_layout(
    id UUID PRIMARY KEY,
    plant_id UUID REFERENCES plants(id),
    layout_id UUID REFERENCES layouts(id),
    x_coord NUMERIC(10, 2) NOT NULL,
    y_coord NUMERIC(10, 2) NOT NULL,
    diameter NUMERIC(5, 2) NOT NULL,
    height NUMERIC(5, 2) NOT NULL
);

CREATE TABLE fave_design(
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    design_id UUID REFERENCES designs(id)
);


-- Users Inserts
INSERT INTO users (id, username, password, is_admin) VALUES ('bb672d7d-53c4-4586-a511-ed3a10dadc88', 'Justin', '0710', TRUE) ON CONFLICT (id) DO NOTHING;
INSERT INTO users (id, username, password, is_admin) VALUES ('95d20023-79ca-43fc-8a2e-313bab66d76b', 'Chelsea', '1234', TRUE) ON CONFLICT (id) DO NOTHING;
INSERT INTO users (id, username, password, is_admin) VALUES ('6fd4e60a-92dd-4a6e-af0d-00ce830c61a6', 'Callen', '5678', TRUE) ON CONFLICT (id) DO NOTHING;
INSERT INTO users (id, username, password, is_admin) VALUES ('0b479114-5b4e-4587-b8c0-a32b22e19d8f', 'Ellie', '9012', TRUE) ON CONFLICT (id) DO NOTHING;

-- Designs Inserts
INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '637f077b-90af-498b-916c-40b3c1477808',
  'modern minimalism',
  'A sleek, refined space defined by sculptural plants, white space, and minimal materials. Focused on balance, simplicity, and restraint.',
  'A Modern Minimalism garden distills modern design to its purest form. It emphasizes sculptural simplicity, white space, and deliberate restraint in both planting and materials. With sparse, architectural elements and a limited palette, the space feels quiet and refined. Negative space is used as intentionally as the plantings, celebrating geometry, balance, and thoughtful reduction.',
  'linear, asymmetrical, informal hierarchy, odd spacing, abstraction, rhythm, massing, limited palette, white space, focus on restraint, sparce, sculptural'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '448c92e6-aee5-41d9-98d4-38dc07417845',
  'modern lush',
  'Blends modern structure with rich, dense planting. A limited palette and strong forms create rhythm and depth, achieving a lush, immersive feel without visual clutter.',
  'A Modern Lush garden blends the clean lines and structured aesthetic of modern design with rich, textural planting. While maintaining asymmetry and abstraction, this style embraces fullness—layering dense foliage and masses of plants to create a continuous visual rhythm. It incorporates restraint through a curated color palette and thoughtful repetition, achieving a lush, immersive effect without visual clutter. The result is a sophisticated, tactile space where structure meets abundance.',
  'linear, asymmetrical, informal hierarchy, odd spacing, abstraction, rhythm, massing, limited palette, full, textural, dense, continuous focal point'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '551999e8-c349-4f38-bf88-6b3202483426',
  'classical',
  'Emphasizes symmetry, order, and geometry with manicured lawns, sculpted shrubs, and a restrained palette. Formal structure and repetition create timeless elegance.',
  'A Classical garden emphasizes structure, balance, and timeless elegance. Rooted in symmetry and formal hierarchy, this style features linear layouts, geometric planting patterns, and meticulously defined borders—often through evergreen hedges or hardscaping that remain present year-round. Gardens are typically curated around a formal path system that leads the eye toward focal points such as fountains, sculptures, or neatly clipped topiary. Plantings follow a limited color palette, typically favoring greens and whites, with repetition and order reinforcing a sense of calm and control. Manicured lawns, sculpted shrubs, and ornamental elements lend a sense of refinement and grandeur.',
  'geometrical, symmetrical, formal hierarchy, even spacing, order, repetition, massing, limited palette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '5cb6a600-9642-432f-ac5c-a33982b88fcf',
  'cottage',
  'A colorful, romantic garden filled with densely layered flowers and herbs. Informal and abundant, it blends ornament and utility with personal charm.',
  'While it shares the wild charm and informality of a naturalistic garden, the Cottage garden adds a distinctly romantic and curated flair. Overflowing with color, scent, and personality, this style mixes edible and ornamental plants in a dense, layered fashion that feels spontaneous but often reflects human intention. Cottage gardens typically favor traditional favorites—roses, herbs, and self-seeding perennials—arranged in a way that suggests abundance and lived-in comfort. Unlike naturalistic gardens, which aim to mimic native ecosystems, cottage gardens lean into nostalgic beauty and personal expression, with a looser relationship to ecological function.',
  'overflowing, layered, romantic, whimsical, nostalgic, informal, colorful, fragrant, cottagecore, natural'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '752b56be-1ce6-46af-9e13-cdc800459b3f',
  'naturalistic',
  'A relaxed, organic garden inspired by native landscapes. Flowing plant groupings and natural materials create a vibrant, ever-changing space full of life and movement.',
  'A Naturalistic garden embraces the untamed beauty of nature, blurring the boundary between cultivated space and wild landscape. Inspired by native ecosystems—from sun-drenched prairies to shaded woodlands—this style prioritizes biodiversity, habitat creation, and ecological harmony. Plants are arranged in loose, organic patterns that mimic natural plant communities, with clumped or scattered groupings and no formal hierarchy. Materials like stone, wood, and gravel blend seamlessly into the environment, while color, texture, and form follow the rhythms of the surrounding landscape. Whether open and airy or densely layered, naturalistic gardens evolve with the seasons and invite both people and wildlife into a living, dynamic space.',
  'meandering, random, lack of hierarchy, no spacing rules, wild, scattered, clumped, large palette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '84471857-6117-4236-8680-977cd4786e56',
  'naturalistic woodland',
  'Shade-loving native plants arranged in soft layers under trees. Inspired by forest floors, it feels quiet, textured, and seasonal.',
  'Shaded and serene, the Woodland naturalistic garden draws inspiration from forest understories and dappled glades. Plantings emphasize shade-loving natives such as ferns, groundcovers, woodland grasses, and spring ephemerals, arranged in loose layers that follow the natural contours of the land. Trees and understory shrubs provide vertical structure, while mosses, leaf litter, and natural stone pathways create a grounded, organic feel. Designed to feel untouched and timeless, this garden thrives in full to partial shade and encourages seasonal shifts, from early spring blooms to the golden tones of fall.',
  'meandering, random, lack of hierarchy, no spacing rules, wild, scattered, clumped, large palette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '6eea3361-68ae-4346-95c3-87e51e21dd55',
  'naturalistic prairie',
  'Sun-loving grasses and wildflowers arranged in natural drifts. A dynamic, low-intervention garden full of movement, color, and habitat value.',
  'Expansive, sun-filled, and dynamic, the Prairie naturalistic garden mimics the beauty and resilience of native grasslands. Tall and short grasses—such as little bluestem or switchgrass—sway among vibrant wildflowers in irregular, intermingled groupings. Designed for full sun and open exposure, this style values movement, pollinator support, and long-season interest. Drifts of color, clumps of texture, and soft transitions between plants create a living tapestry that changes daily. Hardscaping is minimal, allowing the planting palette and the play of wind and light to take center stage.',
  'meandering, random, lack of hierarchy, no spacing rules, wild, scattered, clumped, large palette'
) ON CONFLICT (id) DO NOTHING;

-- Plants Inserts
INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'db48e63f-17e7-4629-9ed0-5478a47eb339',
  'prairie acacia',
  NULL,
  'acacia angustissima',
  'shrub',
  TRUE,
  'full-sun, part-shade',
  1,
  4,
  1.5,
  2,
  'spring, fall',
  NULL,
  'reddish_brown',
  NULL
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'c465b72d-0929-4637-b230-7ce89ad15e51',
  'splitbeard bluestem',
  NULL,
  'andropogon ternarius',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2,
  4,
  0.5,
  1,
  'summer, fall, winter',
  NULL,
  'brown',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282045/cedar-sedge_hwoyoo.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'efb37929-7e64-4fd0-a5d0-e283c1e20123',
  'false boneset',
  'brickellbush',
  'brickellia eupatorioides',
  'herbaceous',
  FALSE,
  'full-sun, part-shade',
  3,
  4,
  1,
  2,
  'summer, fall',
  NULL,
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287878/brickelliacalifornica_hxewed.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '4f747e27-9bc3-4523-8253-91ddaf409090',
  'cedar sedge',
  NULL,
  'carex planostachys',
  'grass & sedge',
  FALSE,
  'full-sun',
  0.5,
  4,
  1,
  1,
  'spring, summer',
  NULL,
  'green',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287880/carex_angustisquama_yamatanukirn04_ofai6o.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'c5416ed0-c469-432a-8267-a947d09ac31d',
  'hairy sunflower',
  'rough sunflower',
  'helianthus hirsutus',
  'herbaceous',
  FALSE,
  'full-sun, part-shade, shade',
  3,
  6,
  2,
  3,
  'summer, fall',
  NULL,
  'yellow',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287882/hairy_sunflower__1020466042_hodmut.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f21326da-0be6-4aa0-8b70-e54a53c6d04b',
  'elephant ear',
  NULL,
  'colocasia esculenta',
  'herbaceous',
  TRUE,
  'full-sun, part-shade, full-shade',
  3,
  6,
  2,
  6,
  'summer, fall, winter',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282053/elephant-ear_nwvvue.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '856a2446-a8a5-424d-9a18-f28030a9147c',
  'foxtail fern',
  'asparagus fern',
  'asparagus aethiopicus',
  'herbaceous',
  TRUE,
  'part-shade',
  2,
  3,
  2,
  3,
  'summer, fall, winter',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287877/asparagus_densiflorus__myersii_oin8n7.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '311167d5-b57c-4ae5-9e32-25646ed50ce4',
  'pink muhly grass',
  NULL,
  'muhlenbergia capillaris',
  'grass',
  FALSE,
  'full-sun, part-shade',
  2,
  3,
  2,
  3,
  'fall, winter',
  'grass_green',
  'deep_pink',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282058/pink-muhly-grass_z3sumw.webp'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '92a695dc-fdf0-404b-a8f5-58a77fef700e',
  'boxwood',
  NULL,
  'buxus spp.',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2,
  15,
  2,
  4,
  NULL,
  'grass_green',
  NULL,
  'https://res.cloudinary.com/dprixcop0/image/upload/v1753128204/boxwood_gqpns0.webp'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '3b60b71e-aa06-4b13-ad0d-708746b96387',
  'hybrid tea roses',
  NULL,
  'rosa spp.',
  'shrub',
  FALSE,
  'full-sun',
  3,
  6,
  2,
  4,
  NULL,
  NULL,
  NULL,
  NULL
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '01d38131-4442-45bb-9cc0-d3fbd5fd7ef2',
  'lavender',
  NULL,
  'lavendula spp.',
  'shrub',
  FALSE,
  'full-sun',
  1,
  3,
  4,
  5,
  NULL,
  NULL,
  'purple',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282056/lavender_dc4pon.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '71657278-e73d-4cfe-8e40-d074d34ca1de',
  'hydrangeas',
  'big daddy',
  'hydrangea macrophylla',
  'shrub',
  TRUE,
  'full-sun, part-shade, full-shade',
  5,
  6,
  5,
  6,
  'spring, summer',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287885/hydrangea_macrophylla_-_bigleaf_hydrangea2_fjkn5c.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'dcaf20f5-51cd-4ca7-a75d-926b40760c43',
  'lambs ear',
  NULL,
  'stachys byzantina',
  'herbaceous',
  FALSE,
  'full-sun, part-shade',
  6,
  12,
  1,
  3,
  'spring, summer, fall',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282056/lambs-ear_daq1ds.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '63b63452-8271-4b95-b484-10f232370f40',
  'cat''s pajamas catmint',
  NULL,
  'epeta',
  'herbaceous',
  FALSE,
  'full-sun, part-shade',
  0.75,
  2,
  1,
  2,
  'spring, summer, fall',
  NULL,
  'sage_green',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287881/chasmanthium_latifolium_boyle_park_g8rpma.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '457a535f-2919-44b0-bdd9-6f481ea5f316',
  'coneflowers',
  NULL,
  'centaurea cyanus',
  'herbaceous',
  FALSE,
  'full-sun',
  2,
  3,
  2,
  3,
  'spring, summer',
  NULL,
  'pink',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282048/copy_of_cone-flower_zqcl3s.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f45aadb8-f43e-4523-80f6-f34815fab0dc',
  'hakone grass',
  'aurelia',
  'hakonechloa macra',
  'grass',
  FALSE,
  'full-sun, part-shade, full-shade',
  1,
  2,
  1,
  2,
  'spring, summer, fall',
  NULL,
  'yellow',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282055/hakone-grass_inabds.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '4a03629e-147c-43e6-9813-68c0df623d9f',
  'siberian bugloss',
  'jack frost',
  'brunnera macrophylla',
  'herbaceous',
  FALSE,
  'part-shade, full-shade',
  1,
  2,
  1,
  2,
  'spring, summer',
  NULL,
  'blue',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287881/brunnera-macrophhylla-1_xq83za.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f059de27-97ac-4e9a-8aa0-acb6b2c764d1',
  'hellebore',
  NULL,
  'helleborus x nigercors',
  'herbaceous',
  TRUE,
  'part-shade',
  1,
  2,
  1,
  2,
  'spring, winter',
  NULL,
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287885/helleborus_orientalis._lenteroos_04_c7xr2e.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '328391ee-2ef4-4eaf-8319-8de0e2d649f7',
  'chinese silver grass',
  NULL,
  'miscanthus sinensis',
  'grass',
  FALSE,
  'full-sun, part-shade',
  3,
  8,
  3,
  5,
  'summer, fall, winter',
  'grass_green',
  'tan',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287886/japanese_pampas_grass_%e3%82%b9%e3%82%b9%e3%82%ad%e3%81%ae%e7%a9%82%e6%b3%a2pb080105_umyjuu.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '3edbfc94-c004-4d0a-8320-6d664fae6214',
  'century plant',
  NULL,
  'agave americana',
  'succulent',
  TRUE,
  'full-sun',
  3,
  6,
  6,
  10,
  'spring, summer',
  'sage_green',
  'goldenrod',
  NULL
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'b3822504-81fa-4f84-94a0-5b546e9e2efe',
  'inland sea oats',
  NULL,
  'chasmanthium latifolium',
  'grass',
  FALSE,
  'part-shade, full-shade',
  2,
  4,
  1,
  6,
  'fall',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287881/chasmanthium_latifolium_boyle_park_g8rpma.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '864175d7-490b-4fbc-97f7-a27996b212dd',
  'lavender cotton',
  NULL,
  'santolina chamaecyparissus',
  'shrub',
  TRUE,
  'full-sun, part-shade',
  1,
  2,
  2,
  3,
  'spring, summer, fall',
  NULL,
  'silver_gray',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287878/astilbe_rubra_kz2_ijxkt0.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'db0dce21-8373-4bba-b310-e828a0ae757c',
  'japanese painted fern',
  NULL,
  'athyrium niponicum var. pictum',
  'herbaceous',
  TRUE,
  'part-shade, full-shade',
  1,
  1.5,
  1,
  1.5,
  'spring, summer',
  'purple_brown',
  'pale_green',
  'https://res.cloudinary.com/dprixcop0/image/upload/v1753127972/japanese-painted-fern_tioauz.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '0e62f4f0-31f6-4789-a364-8579e12032b0',
  'hosta ''formal attire''',
  NULL,
  'plantain lilies',
  'shrub',
  TRUE,
  'part-shade, full-shade',
  1.5,
  2.5,
  2,
  2.5,
  'spring, summer',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287885/hosta_plantaginea_cv_royal_standard_1_wjby1o.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '0996277b-20f3-4124-bc57-d8d4b3f0c628',
  'astilbe',
  NULL,
  'astilbe',
  'herbaceous',
  FALSE,
  'full-sun, part-shade, full-shade',
  1.5,
  6,
  1.5,
  6,
  'spring, summer',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287878/astilbe_rubra_kz2_ijxkt0.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '3861eff6-dd10-47dc-a1ae-8dc554597284',
  'heuchera ''bella notte''',
  'coral bells, bella notte',
  'bella notte',
  'shrub',
  FALSE,
  'part-shade, full-shade',
  0.75,
  1,
  1,
  1.25,
  'summer, fall',
  NULL,
  NULL,
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753287889/san_gabriel_mountains_coralbells_wmtf7w.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'bfac560a-373b-4c47-924d-3cc6438ed55c',
  'foamflower',
  NULL,
  'tiarella cordifolia',
  'herbaceous',
  FALSE,
  'part-shade, full-shade',
  0.5,
  1,
  1,
  2,
  'summer',
  'lime_green',
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282055/foamflower_hw5oc7.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f7cb9670-21f1-414b-b135-5757a9a2312b',
  'spreading plum yew',
  'spreading japanese plum yew',
  'cephalotaxus harringtonia ''prostrata''',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2,
  3,
  3,
  4,
  'summer, fall',
  'lime_green',
  NULL,
  'https://res.cloudinary.com/dprixcop0/image/upload/v1753127016/spreading-japanese-plum-yew_c7753v.webp'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f43acde8-e473-43ca-83b7-f5ede34dd35c',
  'anacacho orchid tree',
  NULL,
  'bauhinia lunarioides',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  6,
  12,
  3,
  6,
  'spring',
  'sage_green',
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282044/anacacho-orchid-tree_fw1xpf.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '511c1a96-fa0e-4c7d-8363-ece0c7d9f528',
  'teresa''s texas sage',
  NULL,
  'salvia greggii ''teresa''',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2.5,
  3,
  2.5,
  3,
  'spring, summer',
  'grass_green',
  'baby_lavender',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282058/teresas-texas-sage_evcdgc.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'd95c8054-8893-45a0-bc92-b5c2ca595724',
  'blackfoot daisy',
  NULL,
  'melampodium leucanthum',
  'herbaceous',
  FALSE,
  'full-sun, part-shade',
  0.5,
  1,
  1,
  2,
  'spring, summer, fall',
  'grass_green',
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282046/copy_of_anacacho-orchid-tree_vovrrs.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'baaccd35-261e-41c0-995b-daa654607e7c',
  'flame acanthus',
  NULL,
  'anisacanthus quadrifidus',
  'shrub',
  FALSE,
  'full-sun, part-shade, full-shade',
  3,
  5,
  2,
  4,
  'summer, fall',
  'lime_green',
  'red_orange',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282054/flame-acanthus_e0ci4n.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '761cc6c3-a042-4b14-9854-6c7ae107bad7',
  'mealy blue sage',
  NULL,
  'salvia farinacea',
  'shrub',
  FALSE,
  'full-sun',
  2,
  3,
  3,
  3,
  'spring, summer, fall',
  'sage_green',
  'lavender',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282056/mealy-blue-sage_ixgfxa.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '9816d103-9ed1-4bd4-81ff-35449ca470b5',
  'texas sotol',
  NULL,
  'dasylirion texanum',
  'shrub',
  FALSE,
  'full-sun',
  1.5,
  2.5,
  1.5,
  2.5,
  'summer',
  'grass_green',
  'yellow',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282059/texas-sotol_qaxtys.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '97089489-1b3e-4453-9719-c1e8c4ad5f36',
  'white autumn sage',
  NULL,
  'salvia greggii ‘white’',
  'shrub',
  FALSE,
  'full-sun, part-shade',
  2,
  3,
  2,
  3,
  'spring, summer',
  'grass_green',
  'baby_lavender',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282059/white-autumn-sage_ekfmqt.jpg'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'd1b1b075-a7c1-4761-9236-8be3b9735bce',
  'mexican feathergrass',
  NULL,
  'nassella tenuissima',
  'grass',
  FALSE,
  'full-sun, part-shade',
  1,
  3,
  1,
  3,
  'summer',
  'pale_green',
  'white',
  'https://res.cloudinary.com/dmlezxkp3/image/upload/v1753282056/mexican-feathergrass_tdsafo.jpg'
) ON CONFLICT (id) DO NOTHING;

-- plant_Design_Types Inserts
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f1a1be02-09e9-4d01-bafb-a137ff60f435', 'db48e63f-17e7-4629-9ed0-5478a47eb339', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c71f8c14-ba81-4db5-9658-938ed4d686d3', 'db48e63f-17e7-4629-9ed0-5478a47eb339', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fb769027-0aa2-4094-8b7c-fb7830faaed9', 'db48e63f-17e7-4629-9ed0-5478a47eb339', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bc47c0ba-f16d-4a9a-bd16-103aaac84726', 'db48e63f-17e7-4629-9ed0-5478a47eb339', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ff906260-4a75-4c25-bf4e-58213e8b5fc4', 'c465b72d-0929-4637-b230-7ce89ad15e51', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9ea57dd3-3037-4386-8c71-698cdbf2abdb', 'c465b72d-0929-4637-b230-7ce89ad15e51', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2824f154-ae75-44f3-989e-54b33ba5a5dd', 'c465b72d-0929-4637-b230-7ce89ad15e51', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('122ea28d-ca6f-4815-bdcb-8c68230982fd', 'c465b72d-0929-4637-b230-7ce89ad15e51', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('773440d8-bc01-4ea8-8837-1cc2a87776aa', 'c465b72d-0929-4637-b230-7ce89ad15e51', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('84b86c57-3ad6-48f3-9a0b-2bb11ac8bf3b', 'efb37929-7e64-4fd0-a5d0-e283c1e20123', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3a0319a6-c2d2-484c-825b-e8d3e7afada4', 'efb37929-7e64-4fd0-a5d0-e283c1e20123', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b424c43c-348e-42b4-8cc0-2d44418a631d', '4f747e27-9bc3-4523-8253-91ddaf409090', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2bb8590c-1436-493f-859b-e21132ea0738', '4f747e27-9bc3-4523-8253-91ddaf409090', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('84104b3f-3e96-4e2c-ae0e-f9582098380a', '4f747e27-9bc3-4523-8253-91ddaf409090', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e4286b3f-fa3e-4da0-aae8-c752bf503720', '4f747e27-9bc3-4523-8253-91ddaf409090', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c52003ae-f713-4bc5-a6b3-21b86c7e2e30', 'c5416ed0-c469-432a-8267-a947d09ac31d', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('371ead2d-fa8c-489d-836c-90d575d2d8b1', 'c5416ed0-c469-432a-8267-a947d09ac31d', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('24072e4f-f0f3-4670-90b8-0b40bd3c6658', 'f21326da-0be6-4aa0-8b70-e54a53c6d04b', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a62233c8-3604-4225-a58f-a9cd89b50ccd', 'f21326da-0be6-4aa0-8b70-e54a53c6d04b', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5aaee0ae-acc3-40e1-9a42-dfbc7bee4179', 'f21326da-0be6-4aa0-8b70-e54a53c6d04b', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e306901e-ebc7-42e8-9950-9e6bd35742b6', 'f21326da-0be6-4aa0-8b70-e54a53c6d04b', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b7e553b7-4636-4912-805d-dc57376f9342', '856a2446-a8a5-424d-9a18-f28030a9147c', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0df7a1b5-536b-444e-99bc-b6b85d682d6c', '856a2446-a8a5-424d-9a18-f28030a9147c', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('634abf40-1435-4aee-991c-f578ef9bfff5', '856a2446-a8a5-424d-9a18-f28030a9147c', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d9c2d43d-3893-4d8d-a047-681e3de03f1c', '856a2446-a8a5-424d-9a18-f28030a9147c', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d7dc8a88-377f-468a-8d6c-85364ee30d4d', '311167d5-b57c-4ae5-9e32-25646ed50ce4', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f30135c6-b363-450e-b1a5-8630eb77192c', '311167d5-b57c-4ae5-9e32-25646ed50ce4', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('48142bfb-d467-44bd-beae-96856db60dcd', '311167d5-b57c-4ae5-9e32-25646ed50ce4', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f0336320-1633-42f8-bf98-7c37b82ab109', '311167d5-b57c-4ae5-9e32-25646ed50ce4', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('269b99e3-fa6c-42c8-98fa-717154bea354', '311167d5-b57c-4ae5-9e32-25646ed50ce4', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7d230588-e785-4c1d-89e2-076fc1428d27', '92a695dc-fdf0-404b-a8f5-58a77fef700e', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6f3ce3a3-0336-4201-8b87-bb600833e29e', '92a695dc-fdf0-404b-a8f5-58a77fef700e', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d5368ec1-9e7d-4da4-adb0-74a2d8d9b6b3', '92a695dc-fdf0-404b-a8f5-58a77fef700e', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5f3b9b29-4b26-4cb7-888b-e239c33ff19d', '3b60b71e-aa06-4b13-ad0d-708746b96387', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('97e89d78-9854-452c-84f0-d4d8feb3f5c3', '01d38131-4442-45bb-9cc0-d3fbd5fd7ef2', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7994a901-fabd-431d-8cce-0fbee7d6e9ba', '01d38131-4442-45bb-9cc0-d3fbd5fd7ef2', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('87b42a83-6690-48f8-a7bb-3c3f5975d4c5', '01d38131-4442-45bb-9cc0-d3fbd5fd7ef2', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a4ed1490-d90f-4d44-84ac-972f8dea65de', '01d38131-4442-45bb-9cc0-d3fbd5fd7ef2', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('707d78b3-914a-4619-8d77-7df1c3a29ca7', '01d38131-4442-45bb-9cc0-d3fbd5fd7ef2', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('74beba1d-bc54-4f56-bae7-9755bd227176', '71657278-e73d-4cfe-8e40-d074d34ca1de', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('94853c39-1553-43fa-8b2c-d97dd9cb2235', '71657278-e73d-4cfe-8e40-d074d34ca1de', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('da64654a-d411-4cc7-8252-0a152fd3490c', '71657278-e73d-4cfe-8e40-d074d34ca1de', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('97670ff3-de83-4e50-ad48-2ee6625c295a', 'dcaf20f5-51cd-4ca7-a75d-926b40760c43', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1f1e9957-1d6f-40f8-821f-f72b10aab524', 'dcaf20f5-51cd-4ca7-a75d-926b40760c43', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3e7dd33a-8522-4125-9edd-9201da4f003c', 'dcaf20f5-51cd-4ca7-a75d-926b40760c43', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('41b2e4d2-f5ae-4bb5-add1-cb1e39e8ad9b', 'dcaf20f5-51cd-4ca7-a75d-926b40760c43', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fad9deb7-8a20-485c-9f17-14d73741fa61', 'dcaf20f5-51cd-4ca7-a75d-926b40760c43', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('13712122-6025-43bf-94aa-0189d8cb4b61', '63b63452-8271-4b95-b484-10f232370f40', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('622ea046-46fa-4f71-991c-bc217d7ebd40', '63b63452-8271-4b95-b484-10f232370f40', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4efbed4f-9fad-4305-96fd-1511f89d0c82', '63b63452-8271-4b95-b484-10f232370f40', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8b267623-56fd-4442-b009-c30c3be213b3', '63b63452-8271-4b95-b484-10f232370f40', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3094d43a-57c8-47b3-875b-905c856a75b6', '63b63452-8271-4b95-b484-10f232370f40', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fc604485-354a-495c-941a-4341a0a8597f', '457a535f-2919-44b0-bdd9-6f481ea5f316', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c67b7dc3-410f-4f1b-a868-6778c3889ab0', '457a535f-2919-44b0-bdd9-6f481ea5f316', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a60dd983-4a35-48e8-b1c0-3bb81d858fc9', '457a535f-2919-44b0-bdd9-6f481ea5f316', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('da45ac97-1dce-4d3c-8cd8-c1920d83cb05', '457a535f-2919-44b0-bdd9-6f481ea5f316', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8266eaac-37e4-42f0-9bff-90b4545a349b', 'f45aadb8-f43e-4523-80f6-f34815fab0dc', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c26fda0e-a221-47d2-a698-513037087181', 'f45aadb8-f43e-4523-80f6-f34815fab0dc', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5f7b859f-b88a-43e5-896f-db1da34f1f4e', 'f45aadb8-f43e-4523-80f6-f34815fab0dc', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('35883d0b-b1d3-444e-bc2e-360d196924cc', 'f45aadb8-f43e-4523-80f6-f34815fab0dc', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3d829b16-50a1-4201-863f-13ad23206306', 'f45aadb8-f43e-4523-80f6-f34815fab0dc', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('02873c56-db81-4144-a261-72d1b6187bb8', '4a03629e-147c-43e6-9813-68c0df623d9f', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8f3e46dd-1e55-4c19-994f-8897c8da36ef', '4a03629e-147c-43e6-9813-68c0df623d9f', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e3a40555-884a-4518-b22d-724351bda352', '4a03629e-147c-43e6-9813-68c0df623d9f', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f9ddcec1-0854-4ad1-8dda-70ef93f0be50', 'f059de27-97ac-4e9a-8aa0-acb6b2c764d1', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0280a7be-e705-4ea1-80a4-01d833f48f0e', 'f059de27-97ac-4e9a-8aa0-acb6b2c764d1', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6b456ded-c246-4fab-b51b-93c57b90df2e', 'f059de27-97ac-4e9a-8aa0-acb6b2c764d1', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a479ccd8-d6c5-4403-8dc0-6b30208cbd72', '328391ee-2ef4-4eaf-8319-8de0e2d649f7', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4684a85f-3250-4c5e-8516-86b1ec802ef0', '328391ee-2ef4-4eaf-8319-8de0e2d649f7', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9b67680b-fa75-4c26-813d-6de06ff480cb', '328391ee-2ef4-4eaf-8319-8de0e2d649f7', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ad60da99-c0a8-412f-abb9-8658be5e0674', '328391ee-2ef4-4eaf-8319-8de0e2d649f7', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fcb3caa0-1161-4636-8c5d-204d1b5872bb', '328391ee-2ef4-4eaf-8319-8de0e2d649f7', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1df627c5-4285-455f-a9f7-18914a48ade5', '3edbfc94-c004-4d0a-8320-6d664fae6214', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9b40db41-b016-41e9-98fd-d2421ed920ed', '3edbfc94-c004-4d0a-8320-6d664fae6214', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('30a853f0-495f-491d-8c7c-bdface751e3a', '3edbfc94-c004-4d0a-8320-6d664fae6214', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('63bc9f1e-41b3-4883-8ed0-56646e00a2c9', 'b3822504-81fa-4f84-94a0-5b546e9e2efe', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('aa1b82ee-6b01-43ce-b488-8bc05a5c1ef9', 'b3822504-81fa-4f84-94a0-5b546e9e2efe', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b8915294-52fd-4839-bb0a-b6ae37abf534', 'b3822504-81fa-4f84-94a0-5b546e9e2efe', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3e8f48aa-9b5c-4a5f-a418-7326302b9e36', 'b3822504-81fa-4f84-94a0-5b546e9e2efe', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ce257848-23e7-45a7-8beb-90063de53b44', 'b3822504-81fa-4f84-94a0-5b546e9e2efe', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ebc3c712-50a9-43a7-a30a-6599a7e245bb', '864175d7-490b-4fbc-97f7-a27996b212dd', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a194dd62-1c5f-45e5-bba1-a432e7e5774b', '864175d7-490b-4fbc-97f7-a27996b212dd', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('33bd031d-e330-499c-9fa8-d9031508f510', '864175d7-490b-4fbc-97f7-a27996b212dd', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ac94b48d-6c8a-406f-8a57-2cd1036080bf', '864175d7-490b-4fbc-97f7-a27996b212dd', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('97470d90-a1f2-4614-b231-a89a4c9afc59', 'db0dce21-8373-4bba-b310-e828a0ae757c', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('daf0fd94-7b16-4250-8c56-38a9f9e3e79a', 'db0dce21-8373-4bba-b310-e828a0ae757c', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('abec9d90-7838-45fa-99f0-3ac88b0d5ddd', 'db0dce21-8373-4bba-b310-e828a0ae757c', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1109cd44-de43-404a-932b-07f083bef588', 'db0dce21-8373-4bba-b310-e828a0ae757c', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3f7c5f24-377d-4550-81e7-45b60af154fc', 'db0dce21-8373-4bba-b310-e828a0ae757c', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('19cbfb9e-e232-45c0-a836-db47e894126c', '0e62f4f0-31f6-4789-a364-8579e12032b0', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('936bc436-bf35-4174-a5ca-717d30c4779d', '0e62f4f0-31f6-4789-a364-8579e12032b0', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ab6c84d2-16fd-4dc6-9d71-3853bf9e264d', '0e62f4f0-31f6-4789-a364-8579e12032b0', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6be986c8-77ab-4ac0-9ec3-ab0e64a8f2be', '0996277b-20f3-4124-bc57-d8d4b3f0c628', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('cfa63e89-5cb8-414f-af86-98d1c938f47c', '0996277b-20f3-4124-bc57-d8d4b3f0c628', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f906f17e-009c-4ae7-a406-defb6a3be05b', '0996277b-20f3-4124-bc57-d8d4b3f0c628', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9f3ab3c6-3caf-45c0-b2a7-c9d6f2f28e83', '0996277b-20f3-4124-bc57-d8d4b3f0c628', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6c49e04e-9c54-4138-9cdb-f7f580c79139', '0996277b-20f3-4124-bc57-d8d4b3f0c628', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7b4d1bf9-c2f0-4702-a633-baf452199ad8', '3861eff6-dd10-47dc-a1ae-8dc554597284', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9768cd5e-0219-42f2-a376-5a9608c864da', '3861eff6-dd10-47dc-a1ae-8dc554597284', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4072affa-efe1-4272-b77e-32cd19586ebb', '3861eff6-dd10-47dc-a1ae-8dc554597284', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('32aa161c-5298-43ec-9b76-c324252fd67f', 'bfac560a-373b-4c47-924d-3cc6438ed55c', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('92b3635d-d12b-4c5e-b488-516ccf2c4fbd', 'bfac560a-373b-4c47-924d-3cc6438ed55c', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('498c94ad-0fe0-4eb0-bff6-a87c50a126ab', 'bfac560a-373b-4c47-924d-3cc6438ed55c', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fbbd88ac-8cfc-4b1c-8f58-0b74e01a0d92', 'f7cb9670-21f1-414b-b135-5757a9a2312b', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('cfb3ba30-6e98-4e48-8178-be5fd4c303a6', 'f7cb9670-21f1-414b-b135-5757a9a2312b', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('81e6e615-a347-4c10-8418-940302d8189c', 'f7cb9670-21f1-414b-b135-5757a9a2312b', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3fea2c1c-2ae0-4bd0-9ccd-649a5163b2b1', 'f7cb9670-21f1-414b-b135-5757a9a2312b', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fc19268c-bc80-457c-9872-bf5da7c08e26', 'f7cb9670-21f1-414b-b135-5757a9a2312b', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('cda95588-6f73-47f9-b2d7-28acf6973521', 'f43acde8-e473-43ca-83b7-f5ede34dd35c', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('cf9a1ffd-ffe1-471b-8b94-2f652c56b77f', 'f43acde8-e473-43ca-83b7-f5ede34dd35c', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2a3989cd-7cb7-4843-befd-47c9c046c519', 'f43acde8-e473-43ca-83b7-f5ede34dd35c', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7991c9c9-f972-4a41-ab68-e8dfde1964ac', 'f43acde8-e473-43ca-83b7-f5ede34dd35c', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0b2e30dc-1faa-4549-8308-d5f1829f4982', 'f43acde8-e473-43ca-83b7-f5ede34dd35c', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5a4e8ff8-6847-46e3-b5c4-ce09505bf01d', '511c1a96-fa0e-4c7d-8363-ece0c7d9f528', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1b16f42c-02ab-4f84-8554-1231cde7642a', '511c1a96-fa0e-4c7d-8363-ece0c7d9f528', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a827c9de-dc8d-4a18-940e-cf3ffeb4c64a', '511c1a96-fa0e-4c7d-8363-ece0c7d9f528', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('76052a11-71b5-4537-96c3-c85c2e0a662c', '511c1a96-fa0e-4c7d-8363-ece0c7d9f528', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0bcb6412-0788-4beb-b94b-3d0e6828ea4d', '511c1a96-fa0e-4c7d-8363-ece0c7d9f528', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('63d9c670-084e-4445-bb35-0518aa3c957d', 'd95c8054-8893-45a0-bc92-b5c2ca595724', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b5229201-dbad-4c8a-b613-1f30fd6cd24b', 'd95c8054-8893-45a0-bc92-b5c2ca595724', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('157c8992-7fb4-4678-9868-726943c5b7f5', 'd95c8054-8893-45a0-bc92-b5c2ca595724', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('196706b4-949f-43d2-a436-051083afc81e', 'baaccd35-261e-41c0-995b-daa654607e7c', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('37a941e6-8e42-471f-85ca-13fcaa0165f9', 'baaccd35-261e-41c0-995b-daa654607e7c', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0dfc84b5-17c4-48c1-b5b3-6230a4b509c5', 'baaccd35-261e-41c0-995b-daa654607e7c', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5e88906c-9995-40cb-b27e-de95b2ed9141', 'baaccd35-261e-41c0-995b-daa654607e7c', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fbcfb91c-e1a7-4d8f-8f06-8f54fe2f1ea6', 'baaccd35-261e-41c0-995b-daa654607e7c', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f8f14b3e-402a-4545-85ef-747e28863327', '761cc6c3-a042-4b14-9854-6c7ae107bad7', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8f2eed14-9ccd-48a9-9ff4-6c65acb3273d', '761cc6c3-a042-4b14-9854-6c7ae107bad7', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5dddcb90-ed57-47e3-8625-639b2b892b72', '761cc6c3-a042-4b14-9854-6c7ae107bad7', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('196784f9-2412-4ee9-bf6e-b5e0cd596934', '9816d103-9ed1-4bd4-81ff-35449ca470b5', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7cb9467d-7f00-4d84-b1ab-ed32a2ea550d', '9816d103-9ed1-4bd4-81ff-35449ca470b5', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b3472fe6-b532-4637-bd99-5eb21ce9f953', '9816d103-9ed1-4bd4-81ff-35449ca470b5', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('48864cb6-9ad0-44cb-86c9-ef7092568045', '9816d103-9ed1-4bd4-81ff-35449ca470b5', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a10eb7b0-8281-4ef2-ba26-e91e8d00e1ff', '97089489-1b3e-4453-9719-c1e8c4ad5f36', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('eb60a89e-9edf-458c-aede-a384344356e8', '97089489-1b3e-4453-9719-c1e8c4ad5f36', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('cea69d28-fcdf-4446-bf37-192275815d27', '97089489-1b3e-4453-9719-c1e8c4ad5f36', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('141131ec-917a-48fe-882a-78dad0e31ce2', '97089489-1b3e-4453-9719-c1e8c4ad5f36', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0eb72ece-53c7-4cd1-9b15-68ee21fa659c', '97089489-1b3e-4453-9719-c1e8c4ad5f36', '551999e8-c349-4f38-bf88-6b3202483426') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('db14e89f-34a7-4ba6-bc8e-4e319ba81113', 'd1b1b075-a7c1-4761-9236-8be3b9735bce', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('606a585d-2674-4b0b-9810-58a994ceee25', 'd1b1b075-a7c1-4761-9236-8be3b9735bce', '448c92e6-aee5-41d9-98d4-38dc07417845') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('056bbb4e-2476-4736-96e1-42f6a820736d', 'd1b1b075-a7c1-4761-9236-8be3b9735bce', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('426b4458-5356-4b78-9273-129b0ed3f056', 'd1b1b075-a7c1-4761-9236-8be3b9735bce', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (plant_id, design_id) DO NOTHING;

-- Projects Inserts
INSERT INTO projects (id, project_name, user_id) VALUES ('731f4907-cbad-49df-a897-90bdd782bf8d', 'BackyardForest', 'bb672d7d-53c4-4586-a511-ed3a10dadc88') ON CONFLICT (id) DO NOTHING;

-- Layouts Inserts
INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id) VALUES (
  'a0107308-0f51-4a43-a77c-889a61eda30f',
  'newBeginnings',
  10,
  10,
  '5cb6a600-9642-432f-ac5c-a33982b88fcf',
  '731f4907-cbad-49df-a897-90bdd782bf8d'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id) VALUES (
  '44c1c658-2adc-4a66-b083-5a6bc98e3d36',
  'FernForest',
  12,
  6,
  '637f077b-90af-498b-916c-40b3c1477808',
  '731f4907-cbad-49df-a897-90bdd782bf8d'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id) VALUES (
  '9d9d0ad8-cc82-4621-a6c7-8c374d2fd0e7',
  'AbsoluteSucculent',
  15,
  10,
  '752b56be-1ce6-46af-9e13-cdc800459b3f',
  '731f4907-cbad-49df-a897-90bdd782bf8d'
) ON CONFLICT (id) DO NOTHING;


-- Favorite Plants Inserts
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('2143b9d3-3dfe-4953-83be-c421dff453de', 'bb672d7d-53c4-4586-a511-ed3a10dadc88', 'db0dce21-8373-4bba-b310-e828a0ae757c') ON CONFLICT (user_id, plant_id) DO NOTHING;
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('b84fd487-03fc-4cc5-8abe-d02d8f68101d', '0b479114-5b4e-4587-b8c0-a32b22e19d8f', 'f7cb9670-21f1-414b-b135-5757a9a2312b') ON CONFLICT (user_id, plant_id) DO NOTHING;
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('eb545df2-83f6-4e5d-92dc-80c17cb91766', '6fd4e60a-92dd-4a6e-af0d-00ce830c61a6', '92a695dc-fdf0-404b-a8f5-58a77fef700e') ON CONFLICT (user_id, plant_id) DO NOTHING;
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('df537139-b86c-4060-9349-379f1c126c08', '95d20023-79ca-43fc-8a2e-313bab66d76b', 'f7cb9670-21f1-414b-b135-5757a9a2312b') ON CONFLICT (user_id, plant_id) DO NOTHING;

-- Plant Layout Inserts
INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height) VALUES (
  '8e04f7f2-4ee8-4c96-9f4c-308fc818e6e6',
  'db0dce21-8373-4bba-b310-e828a0ae757c',
  'a0107308-0f51-4a43-a77c-889a61eda30f',
  2,
  3,
  1.00,
  1.00
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height) VALUES (
  'b10355fd-3e8b-43d5-84b0-26d586b9269e',
  'f7cb9670-21f1-414b-b135-5757a9a2312b',
  '44c1c658-2adc-4a66-b083-5a6bc98e3d36',
  15,
  7,
  3.00,
  2.00
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height) VALUES (
  '6bacfea9-ec1f-4bf2-9f92-7b488b77654b',
  '92a695dc-fdf0-404b-a8f5-58a77fef700e',
  '9d9d0ad8-cc82-4621-a6c7-8c374d2fd0e7',
  10,
  5,
  2.00,
  2.00
) ON CONFLICT (id) DO NOTHING;


-- Fave Designs Inserts
INSERT INTO fave_design (id, user_id, design_id) VALUES ('860f85c0-ad35-49cf-84bb-579530956413', '0b479114-5b4e-4587-b8c0-a32b22e19d8f', '637f077b-90af-498b-916c-40b3c1477808') ON CONFLICT (id) DO NOTHING;
INSERT INTO fave_design (id, user_id, design_id) VALUES ('f57df1cf-48c2-4587-986f-11bb5cab9dfc', '6fd4e60a-92dd-4a6e-af0d-00ce830c61a6', '752b56be-1ce6-46af-9e13-cdc800459b3f') ON CONFLICT (id) DO NOTHING;
INSERT INTO fave_design (id, user_id, design_id) VALUES ('754d4839-8094-4283-9e3f-147825818078', '95d20023-79ca-43fc-8a2e-313bab66d76b', '5cb6a600-9642-432f-ac5c-a33982b88fcf') ON CONFLICT (id) DO NOTHING;

