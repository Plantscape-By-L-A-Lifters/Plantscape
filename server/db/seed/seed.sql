-- SQL SEED File generated on 2025-07-25T21:04:09.867Z


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
INSERT INTO users (id, username, password, is_admin) VALUES ('c52bd3d6-a3b4-460f-a120-f81bdda20a93', 'Justin', '0710', TRUE) ON CONFLICT (id) DO NOTHING;
INSERT INTO users (id, username, password, is_admin) VALUES ('2ffcea13-bd4e-437f-96f6-cbedc1b04063', 'Chelsea', '1234', TRUE) ON CONFLICT (id) DO NOTHING;
INSERT INTO users (id, username, password, is_admin) VALUES ('63cdffc5-c712-45bd-b84f-2ff2444ed6ac', 'Callen', '5678', TRUE) ON CONFLICT (id) DO NOTHING;
INSERT INTO users (id, username, password, is_admin) VALUES ('3f20c4f3-8aef-4304-a6e9-e41e2dbbbfde', 'Ellie', '9012', TRUE) ON CONFLICT (id) DO NOTHING;

-- Designs Inserts
INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '285491c8-23d5-41cb-ac5e-4f6b84ae4d54',
  'modern minimalism',
  'A sleek, refined space defined by sculptural plants, white space, and minimal materials. Focused on balance, simplicity, and restraint.',
  'A Modern Minimalism garden distills modern design to its purest form. It emphasizes sculptural simplicity, white space, and deliberate restraint in both planting and materials. With sparse, architectural elements and a limited palette, the space feels quiet and refined. Negative space is used as intentionally as the plantings, celebrating geometry, balance, and thoughtful reduction.',
  'linear, asymmetrical, informal hierarchy, odd spacing, abstraction, rhythm, massing, limited palette, white space, focus on restraint, sparce, sculptural'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  'c323bcf6-7a17-446d-8ecd-42cbba0304ed',
  'modern lush',
  'Blends modern structure with rich, dense planting. A limited palette and strong forms create rhythm and depth, achieving a lush, immersive feel without visual clutter.',
  'A Modern Lush garden blends the clean lines and structured aesthetic of modern design with rich, textural planting. While maintaining asymmetry and abstraction, this style embraces fullness—layering dense foliage and masses of plants to create a continuous visual rhythm. It incorporates restraint through a curated color palette and thoughtful repetition, achieving a lush, immersive effect without visual clutter. The result is a sophisticated, tactile space where structure meets abundance.',
  'linear, asymmetrical, informal hierarchy, odd spacing, abstraction, rhythm, massing, limited palette, full, textural, dense, continuous focal point'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '20df67be-f474-4dc3-85c4-74bedb3268b2',
  'classical',
  'Emphasizes symmetry, order, and geometry with manicured lawns, sculpted shrubs, and a restrained palette. Formal structure and repetition create timeless elegance.',
  'A Classical garden emphasizes structure, balance, and timeless elegance. Rooted in symmetry and formal hierarchy, this style features linear layouts, geometric planting patterns, and meticulously defined borders—often through evergreen hedges or hardscaping that remain present year-round. Gardens are typically curated around a formal path system that leads the eye toward focal points such as fountains, sculptures, or neatly clipped topiary. Plantings follow a limited color palette, typically favoring greens and whites, with repetition and order reinforcing a sense of calm and control. Manicured lawns, sculpted shrubs, and ornamental elements lend a sense of refinement and grandeur.',
  'geometrical, symmetrical, formal hierarchy, even spacing, order, repetition, massing, limited palette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '77897494-c08d-4ffb-898e-d5768a4f0311',
  'cottage',
  'A colorful, romantic garden filled with densely layered flowers and herbs. Informal and abundant, it blends ornament and utility with personal charm.',
  'While it shares the wild charm and informality of a naturalistic garden, the Cottage garden adds a distinctly romantic and curated flair. Overflowing with color, scent, and personality, this style mixes edible and ornamental plants in a dense, layered fashion that feels spontaneous but often reflects human intention. Cottage gardens typically favor traditional favorites—roses, herbs, and self-seeding perennials—arranged in a way that suggests abundance and lived-in comfort. Unlike naturalistic gardens, which aim to mimic native ecosystems, cottage gardens lean into nostalgic beauty and personal expression, with a looser relationship to ecological function.',
  'overflowing, layered, romantic, whimsical, nostalgic, informal, colorful, fragrant, cottagecore, natural'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '85093f35-1ecb-458e-b89f-5c01d5d4d029',
  'naturalistic',
  'A relaxed, organic garden inspired by native landscapes. Flowing plant groupings and natural materials create a vibrant, ever-changing space full of life and movement.',
  'A Naturalistic garden embraces the untamed beauty of nature, blurring the boundary between cultivated space and wild landscape. Inspired by native ecosystems—from sun-drenched prairies to shaded woodlands—this style prioritizes biodiversity, habitat creation, and ecological harmony. Plants are arranged in loose, organic patterns that mimic natural plant communities, with clumped or scattered groupings and no formal hierarchy. Materials like stone, wood, and gravel blend seamlessly into the environment, while color, texture, and form follow the rhythms of the surrounding landscape. Whether open and airy or densely layered, naturalistic gardens evolve with the seasons and invite both people and wildlife into a living, dynamic space.',
  'meandering, random, lack of hierarchy, no spacing rules, wild, scattered, clumped, large palette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  '626e9681-d4ad-40b6-90a2-71f482e1828f',
  'naturalistic woodland',
  'Shade-loving native plants arranged in soft layers under trees. Inspired by forest floors, it feels quiet, textured, and seasonal.',
  'Shaded and serene, the Woodland naturalistic garden draws inspiration from forest understories and dappled glades. Plantings emphasize shade-loving natives such as ferns, groundcovers, woodland grasses, and spring ephemerals, arranged in loose layers that follow the natural contours of the land. Trees and understory shrubs provide vertical structure, while mosses, leaf litter, and natural stone pathways create a grounded, organic feel. Designed to feel untouched and timeless, this garden thrives in full to partial shade and encourages seasonal shifts, from early spring blooms to the golden tones of fall.',
  'meandering, random, lack of hierarchy, no spacing rules, wild, scattered, clumped, large palette'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes, design_description, design_tags) VALUES (
  'ee9cd2d6-f72b-4947-b37b-0b0ec0296605',
  'naturalistic prairie',
  'Sun-loving grasses and wildflowers arranged in natural drifts. A dynamic, low-intervention garden full of movement, color, and habitat value.',
  'Expansive, sun-filled, and dynamic, the Prairie naturalistic garden mimics the beauty and resilience of native grasslands. Tall and short grasses—such as little bluestem or switchgrass—sway among vibrant wildflowers in irregular, intermingled groupings. Designed for full sun and open exposure, this style values movement, pollinator support, and long-season interest. Drifts of color, clumps of texture, and soft transitions between plants create a living tapestry that changes daily. Hardscaping is minimal, allowing the planting palette and the play of wind and light to take center stage.',
  'meandering, random, lack of hierarchy, no spacing rules, wild, scattered, clumped, large palette'
) ON CONFLICT (id) DO NOTHING;

-- Plants Inserts
INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '1ac1bb5d-34d6-48d4-a245-2aea8f5be290',
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
  'e2aff8c2-8b05-4672-a192-d207593fabe1',
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
  '300b393f-1c27-4a73-8290-cc582a56a21a',
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
  'f60fc737-2a2f-4b52-9acc-1824b2110352',
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
  '94bafad4-58b1-4466-b292-22d3f80b31d8',
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
  '510f6e62-848f-4d9b-9c79-20c51f477415',
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
  '5259cc42-ff31-4a72-9783-4f0bcb0f2ae1',
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
  'ea6bd9ea-8653-40f8-ad40-e298e0b817be',
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
  '24e37bfe-74b1-4f13-af5a-43acab094dc5',
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
  'e0e3d257-444e-46a2-8b42-b956a1748e6c',
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
  '9ceffc72-c4ec-4d29-afe6-90e2d4d8af74',
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
  '2857dcef-6dd0-48c8-916b-12c073fd268b',
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
  '56a23058-45a1-4245-ba42-c1cd9ae379f5',
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
  'e372e279-fa07-4ce9-bc57-37574ed7f565',
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
  '5a42817d-36f3-4553-b179-7231355515a6',
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
  '4bbcf313-cf73-4423-8d0e-3912dad10edb',
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
  'c16e0a69-5cd0-410a-974a-6d64361d54b0',
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
  'cad6454d-d391-4b73-8631-e32d72d4da70',
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
  '2d6f796c-ce96-4fd3-a6f6-edd6de8cecf5',
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
  'aaf4ac72-827f-435a-9c95-2ed223d5964e',
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
  '05fd7815-048d-4bf5-a311-97a43989d6a5',
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
  '1816e66c-348f-4b0d-b204-8e55db4192cc',
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
  'e485742d-3ca0-4a3c-88f6-616d09efe7b9',
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
  'e17c6178-4c52-4682-85bc-017abe940829',
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
  'faad0682-a873-4ab2-8603-c6b8e8b6c149',
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
  'a113724d-d300-410d-98a1-3e72743d3786',
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
  'b529b365-f444-4a9d-a5ef-c66955517ed6',
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
  '1a07378f-6312-492d-bccc-57716f87efb2',
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
  'da87a157-5970-488b-aedf-a1706b9d9436',
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
  'f2c9e854-f679-4d77-9e94-e46a1f8945a5',
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
  'b8cfdfab-86da-4ad9-a584-33222e0199cf',
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
  '07b20472-4b86-46f0-baba-3ce3ecc7c47a',
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
  '8e8fe9a4-305b-4af2-b565-60c3173a52ec',
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
  '60330f9e-fa41-4827-8a23-e64be5885dfd',
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
  'bbf8bd93-9fd9-4c7c-886a-0da787cd689b',
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
  'd16e1afb-d4af-43ae-8e92-8dc11d9cb017',
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
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('dd7523ab-8ed6-4200-ba92-de3f4e161757', '1ac1bb5d-34d6-48d4-a245-2aea8f5be290', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c8439b43-8b1c-4fc1-bba2-4e798a3f3fdc', '1ac1bb5d-34d6-48d4-a245-2aea8f5be290', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('58d4ca2b-980e-42a2-b48e-944e3df96e6c', '1ac1bb5d-34d6-48d4-a245-2aea8f5be290', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('eba7006a-911c-4a38-82df-1a1cd8a4e849', '1ac1bb5d-34d6-48d4-a245-2aea8f5be290', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('57963f8d-c6a3-4ee7-b684-fefa3d3b459b', 'e2aff8c2-8b05-4672-a192-d207593fabe1', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1e526715-ceb2-43ea-a656-4f826265638b', 'e2aff8c2-8b05-4672-a192-d207593fabe1', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d7d953aa-0317-4898-9dd4-219606cb0426', 'e2aff8c2-8b05-4672-a192-d207593fabe1', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0b37aecb-ca0f-4490-9a21-0a1ffd1702af', 'e2aff8c2-8b05-4672-a192-d207593fabe1', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('20453efe-c80b-43cd-bef3-1b6c2b3a228d', 'e2aff8c2-8b05-4672-a192-d207593fabe1', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9a4407f1-37cf-4b10-a76a-b47a092ff07d', '300b393f-1c27-4a73-8290-cc582a56a21a', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b8e57e04-603e-4b76-b22a-b82cfed269b4', '300b393f-1c27-4a73-8290-cc582a56a21a', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('449e93a7-f034-41a4-a65b-b2e226adc151', 'f60fc737-2a2f-4b52-9acc-1824b2110352', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f0538f03-9c89-4da4-a69a-b8100692f109', 'f60fc737-2a2f-4b52-9acc-1824b2110352', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d0688e20-faf3-4b93-a3f2-9bcd3a1b858a', 'f60fc737-2a2f-4b52-9acc-1824b2110352', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1aa95fd0-7936-417e-a0b2-b257da2a46dc', 'f60fc737-2a2f-4b52-9acc-1824b2110352', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('620907c8-c895-4b45-922c-fde67f74b0c3', '94bafad4-58b1-4466-b292-22d3f80b31d8', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('defdd114-39e3-4ccd-b9c7-567ac0a76731', '94bafad4-58b1-4466-b292-22d3f80b31d8', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1281441d-41ef-4889-8a31-8d576c30f67d', '510f6e62-848f-4d9b-9c79-20c51f477415', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('27c75c62-09d6-4ce3-a8fc-627675d6b9c5', '510f6e62-848f-4d9b-9c79-20c51f477415', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e70685ff-2a1d-4e66-adca-fc1b3a97fc7b', '510f6e62-848f-4d9b-9c79-20c51f477415', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('cd76c35d-5443-452e-afaa-f44f25c86fc5', '510f6e62-848f-4d9b-9c79-20c51f477415', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('670999cd-048d-40ac-9852-283a3a7380a0', '5259cc42-ff31-4a72-9783-4f0bcb0f2ae1', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('55cb4392-ab2e-4e90-9c76-ebecd56bfa17', '5259cc42-ff31-4a72-9783-4f0bcb0f2ae1', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('65aa2aa8-45f9-4315-950b-0abda31c6e85', '5259cc42-ff31-4a72-9783-4f0bcb0f2ae1', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ba8e262a-a908-43eb-a6d8-94714d4b2271', '5259cc42-ff31-4a72-9783-4f0bcb0f2ae1', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4f5f222c-f8ae-4f73-9582-0eb456204781', 'ea6bd9ea-8653-40f8-ad40-e298e0b817be', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fda59742-e9c9-45e0-a333-76e3c95fa749', 'ea6bd9ea-8653-40f8-ad40-e298e0b817be', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2b10442b-7c4d-42b4-b054-eceb9e09ea19', 'ea6bd9ea-8653-40f8-ad40-e298e0b817be', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('62d5d133-2563-4319-92e4-c75c5905c622', 'ea6bd9ea-8653-40f8-ad40-e298e0b817be', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2cc9b3bd-ef08-47c5-9e0b-0f8deba16eb5', 'ea6bd9ea-8653-40f8-ad40-e298e0b817be', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('94f6eab4-6ea4-4a32-b5c9-9dca2b445f32', '24e37bfe-74b1-4f13-af5a-43acab094dc5', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4edf8e55-d528-4fc1-a314-accaa79d6416', '24e37bfe-74b1-4f13-af5a-43acab094dc5', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('220c3107-bee2-4dc7-ae8b-42977e047d81', '24e37bfe-74b1-4f13-af5a-43acab094dc5', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d6b368c2-3ab8-4d33-aecf-cec6005352a9', 'e0e3d257-444e-46a2-8b42-b956a1748e6c', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2e147462-ecbb-44fb-a003-c2c46778a57b', '9ceffc72-c4ec-4d29-afe6-90e2d4d8af74', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a721e9d1-e8de-447b-8579-23ad781f7867', '9ceffc72-c4ec-4d29-afe6-90e2d4d8af74', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9af1727a-f572-47c9-bb12-9f0e66291a37', '9ceffc72-c4ec-4d29-afe6-90e2d4d8af74', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('80585098-cb81-4489-8959-78d0f1adda4f', '9ceffc72-c4ec-4d29-afe6-90e2d4d8af74', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e2501811-9c09-4522-a527-5031120847a9', '9ceffc72-c4ec-4d29-afe6-90e2d4d8af74', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3a8fce4a-61fe-4180-a634-bfc442b7f2de', '2857dcef-6dd0-48c8-916b-12c073fd268b', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d07bd462-3c4b-4d89-b5f0-03f4eced3668', '2857dcef-6dd0-48c8-916b-12c073fd268b', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5bff57ea-5865-483d-9e5f-92be84ad9c26', '2857dcef-6dd0-48c8-916b-12c073fd268b', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6bd1d879-82ce-4013-ad2f-e3c97a209c47', '56a23058-45a1-4245-ba42-c1cd9ae379f5', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f8c12b14-4b47-4860-a6a3-57dbc67398ef', '56a23058-45a1-4245-ba42-c1cd9ae379f5', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1f8499d8-d8eb-446e-8f83-835c078514c1', '56a23058-45a1-4245-ba42-c1cd9ae379f5', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('78d129f4-aa60-4881-8a12-5049809afe1f', '56a23058-45a1-4245-ba42-c1cd9ae379f5', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7dd350cd-7c9b-47f5-ae61-6406d0879ff4', '56a23058-45a1-4245-ba42-c1cd9ae379f5', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('99db3c37-057b-4d54-8a13-e5630cfc671c', 'e372e279-fa07-4ce9-bc57-37574ed7f565', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6bd88a81-cabb-4baa-9e20-e9ba58fd9c25', 'e372e279-fa07-4ce9-bc57-37574ed7f565', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9ab62df7-84a8-499d-90cd-5a051b2a19cd', 'e372e279-fa07-4ce9-bc57-37574ed7f565', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b172eb4c-16b5-4d01-88ad-e78714ad19c2', 'e372e279-fa07-4ce9-bc57-37574ed7f565', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7d39fe7e-aab4-4634-a011-2446523745f0', 'e372e279-fa07-4ce9-bc57-37574ed7f565', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0ed63323-59c2-4cab-b046-8f84d55bb145', '5a42817d-36f3-4553-b179-7231355515a6', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4ee55b19-e160-4848-a0fe-b2c316bcdd5f', '5a42817d-36f3-4553-b179-7231355515a6', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('197cae1a-66cb-4e3e-8598-5962f90ccf31', '5a42817d-36f3-4553-b179-7231355515a6', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('79cb5d8f-9ada-4602-9a2e-79c73e98dbe7', '5a42817d-36f3-4553-b179-7231355515a6', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a9988a54-d1d5-4866-b0d6-5e25fd74119a', '4bbcf313-cf73-4423-8d0e-3912dad10edb', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f281d184-2f2b-49db-b6c3-3f4a8067aa78', '4bbcf313-cf73-4423-8d0e-3912dad10edb', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7ec8f16d-0342-4936-9a27-346369e05b7a', '4bbcf313-cf73-4423-8d0e-3912dad10edb', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('46aa3e1e-e99d-4b9a-bcdc-1c7eb96aaeb1', '4bbcf313-cf73-4423-8d0e-3912dad10edb', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9c74e948-5bc9-4232-a797-c0ff30b3dde4', '4bbcf313-cf73-4423-8d0e-3912dad10edb', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7416f0cf-98b2-406d-8798-60511e904eb3', 'c16e0a69-5cd0-410a-974a-6d64361d54b0', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('830b6fe3-d9cc-47af-8f32-3d981527c970', 'c16e0a69-5cd0-410a-974a-6d64361d54b0', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('72966ebd-0be6-49f4-9c4f-6a9793abc2a2', 'c16e0a69-5cd0-410a-974a-6d64361d54b0', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('432b19bf-2348-4a4b-a03c-b52403703fd7', 'cad6454d-d391-4b73-8631-e32d72d4da70', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7ee9b472-5296-48a6-b9c7-9aed73e90b88', 'cad6454d-d391-4b73-8631-e32d72d4da70', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('447aba82-5cc4-45b8-9178-74c6059c5496', 'cad6454d-d391-4b73-8631-e32d72d4da70', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('92d87ecc-2e99-4f37-8940-b83655aedf7a', '2d6f796c-ce96-4fd3-a6f6-edd6de8cecf5', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a3ba964d-7cf9-4dff-97a4-26a0286a940a', '2d6f796c-ce96-4fd3-a6f6-edd6de8cecf5', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9208b752-94f8-47dd-b26c-bbb65131cda9', '2d6f796c-ce96-4fd3-a6f6-edd6de8cecf5', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9eac7d9c-ddfd-4d9d-9e5f-5e4c7f05430d', '2d6f796c-ce96-4fd3-a6f6-edd6de8cecf5', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('cfd251e9-203d-4f36-b365-cf661d1255d5', '2d6f796c-ce96-4fd3-a6f6-edd6de8cecf5', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9e9a1ae8-6bb6-43b1-8637-1148c35b2fcb', 'aaf4ac72-827f-435a-9c95-2ed223d5964e', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6c68159a-5b2b-4f1d-a9fd-52a371549c7f', 'aaf4ac72-827f-435a-9c95-2ed223d5964e', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e3729215-88a0-4514-ac25-c2e350d31e00', 'aaf4ac72-827f-435a-9c95-2ed223d5964e', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('029b53da-27f7-4839-bba4-81ce11b3061c', '05fd7815-048d-4bf5-a311-97a43989d6a5', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bf70086d-e229-4231-9a43-f69364f20073', '05fd7815-048d-4bf5-a311-97a43989d6a5', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('33b1787f-b451-4aab-9797-11dc837ecd73', '05fd7815-048d-4bf5-a311-97a43989d6a5', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0ea799e9-41cb-4338-b710-c5dddb47f867', '05fd7815-048d-4bf5-a311-97a43989d6a5', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c6b945c5-d55d-4607-89c3-362e9fcffafd', '05fd7815-048d-4bf5-a311-97a43989d6a5', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bfbd5f42-5704-45ff-a57b-ffbc36249483', '1816e66c-348f-4b0d-b204-8e55db4192cc', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('776c8a2a-1fa2-41ed-ab35-617c9f36ee90', '1816e66c-348f-4b0d-b204-8e55db4192cc', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('debeff79-2a4e-4ae0-9a39-5da376114ef4', '1816e66c-348f-4b0d-b204-8e55db4192cc', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ee4829a3-eb0d-4a92-95db-965275691ce0', '1816e66c-348f-4b0d-b204-8e55db4192cc', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e91c673a-5025-41fe-8765-3fd7b5503048', 'e485742d-3ca0-4a3c-88f6-616d09efe7b9', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9ae139ac-2e87-4070-9f7a-6695b8c3198f', 'e485742d-3ca0-4a3c-88f6-616d09efe7b9', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('23057a17-5c2b-4f7a-9978-c41fbf8d71f2', 'e485742d-3ca0-4a3c-88f6-616d09efe7b9', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b75bbb8c-0307-4225-a1c1-f3eb70f800c3', 'e485742d-3ca0-4a3c-88f6-616d09efe7b9', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b575a18b-b582-46ea-8fa3-2dc2190b00f4', 'e485742d-3ca0-4a3c-88f6-616d09efe7b9', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0af92a72-520d-4009-9e28-7ac5b7e6ab32', 'e17c6178-4c52-4682-85bc-017abe940829', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0d6e18b2-36c2-46e2-ad9e-cffa6f9dfe9d', 'e17c6178-4c52-4682-85bc-017abe940829', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d4ef418e-a095-4804-8cc6-bab3e4eea272', 'e17c6178-4c52-4682-85bc-017abe940829', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('16a09d64-41a1-4d17-a51f-f479e2275605', 'faad0682-a873-4ab2-8603-c6b8e8b6c149', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b6b37edd-5a20-4e48-a821-8fe4201a0c20', 'faad0682-a873-4ab2-8603-c6b8e8b6c149', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d30c28f3-e969-487d-bdec-fccb3f5f9821', 'faad0682-a873-4ab2-8603-c6b8e8b6c149', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e1cc7d90-179c-4f42-999b-e015096a3b86', 'faad0682-a873-4ab2-8603-c6b8e8b6c149', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('01b325e9-5f05-4aa2-87b4-d3e84914637b', 'faad0682-a873-4ab2-8603-c6b8e8b6c149', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1aa534ae-b7d8-40db-80e0-fc6247725ee5', 'a113724d-d300-410d-98a1-3e72743d3786', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('33638e2a-3076-4532-9c66-5dfc2981fd3e', 'a113724d-d300-410d-98a1-3e72743d3786', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e8986c43-d0fa-4cb6-875f-394c1f1e5445', 'a113724d-d300-410d-98a1-3e72743d3786', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bbfe7940-e636-4f9e-b639-791178c6325e', 'b529b365-f444-4a9d-a5ef-c66955517ed6', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('664bce75-a96d-43ef-8d55-2ff386d68f26', 'b529b365-f444-4a9d-a5ef-c66955517ed6', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('da4754ee-c086-4f61-95b8-ff578cec0416', 'b529b365-f444-4a9d-a5ef-c66955517ed6', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d29471f6-ac9c-4b2e-a50f-ad49cf24bca8', '1a07378f-6312-492d-bccc-57716f87efb2', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('696e55f3-29e3-450f-b922-1e4d1b37c9f0', '1a07378f-6312-492d-bccc-57716f87efb2', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('308359a6-6df7-45a8-940f-4a6d6423aaba', '1a07378f-6312-492d-bccc-57716f87efb2', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f0107db0-4cf8-4295-aeea-874e5599f146', '1a07378f-6312-492d-bccc-57716f87efb2', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('123195c6-8ad6-4fcc-8d2f-8116c0b85504', '1a07378f-6312-492d-bccc-57716f87efb2', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f3252add-caaf-4a96-ad8a-ede8dc2ba1d0', 'da87a157-5970-488b-aedf-a1706b9d9436', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('31c0a6ed-a3bf-46a8-b130-3b6bc6e84e02', 'da87a157-5970-488b-aedf-a1706b9d9436', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4593e347-2139-4528-b128-9d363e64cd8c', 'da87a157-5970-488b-aedf-a1706b9d9436', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8bd4e7db-04e3-4662-975e-557a4dd6daa5', 'da87a157-5970-488b-aedf-a1706b9d9436', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d3abe15b-7c33-4456-8be6-be66bd23f5bd', 'da87a157-5970-488b-aedf-a1706b9d9436', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('901075ef-f4e2-41fe-b66e-131b0a594121', 'f2c9e854-f679-4d77-9e94-e46a1f8945a5', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('340d80e2-ae44-47c1-8e26-baf54fbdb291', 'f2c9e854-f679-4d77-9e94-e46a1f8945a5', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('df190c4c-24a2-4be5-b094-d78e166cc72c', 'f2c9e854-f679-4d77-9e94-e46a1f8945a5', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c80faf1a-f7d2-462e-a0e0-a24ca816f375', 'f2c9e854-f679-4d77-9e94-e46a1f8945a5', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('34c0687a-1357-4e35-8fc4-d5cb5277772a', 'f2c9e854-f679-4d77-9e94-e46a1f8945a5', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5c110eff-0cbf-4bfe-a5a7-b61d5b6f3339', 'b8cfdfab-86da-4ad9-a584-33222e0199cf', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('78fe95e0-a66a-43d1-9ac8-83dcb059a054', 'b8cfdfab-86da-4ad9-a584-33222e0199cf', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e96cac06-02ef-4dbd-8171-bd6a76042399', 'b8cfdfab-86da-4ad9-a584-33222e0199cf', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f8718334-909c-442a-8212-1d5a809b48fd', '07b20472-4b86-46f0-baba-3ce3ecc7c47a', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('da5d5a26-3a04-465a-9f25-183b9295bbc1', '07b20472-4b86-46f0-baba-3ce3ecc7c47a', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a79be26d-4d50-4abf-bb1a-defb331429b5', '07b20472-4b86-46f0-baba-3ce3ecc7c47a', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('147db097-5fc9-4307-91ce-397e1c29767b', '07b20472-4b86-46f0-baba-3ce3ecc7c47a', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('68b7b2b9-a0c1-40bb-9109-b64cc764928d', '07b20472-4b86-46f0-baba-3ce3ecc7c47a', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9ba75008-cd18-4dad-a4a7-4189b47061b7', '8e8fe9a4-305b-4af2-b565-60c3173a52ec', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('aa7ae5a0-39c9-4a83-a87e-f175f425f5eb', '8e8fe9a4-305b-4af2-b565-60c3173a52ec', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('183f59b8-4a26-413e-a024-00857e7fe7db', '8e8fe9a4-305b-4af2-b565-60c3173a52ec', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bf0fd490-a797-4fcc-83e3-16c57879aaf2', '60330f9e-fa41-4827-8a23-e64be5885dfd', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3485c989-db04-4c65-b7e2-6654e40af273', '60330f9e-fa41-4827-8a23-e64be5885dfd', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('15015cfa-a93b-41f0-b53c-02c7895b5347', '60330f9e-fa41-4827-8a23-e64be5885dfd', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('83711ce0-803d-4125-96e5-5c81c0970d8f', '60330f9e-fa41-4827-8a23-e64be5885dfd', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('eea0e949-d470-43e8-ad99-953828b5a6b3', 'bbf8bd93-9fd9-4c7c-886a-0da787cd689b', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9509d361-c090-4f23-807f-d15d383236c7', 'bbf8bd93-9fd9-4c7c-886a-0da787cd689b', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9c75d858-4cf3-45b9-81bf-88142da8eded', 'bbf8bd93-9fd9-4c7c-886a-0da787cd689b', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('dae038b3-4226-4407-8ae0-00dc0f7c82e5', 'bbf8bd93-9fd9-4c7c-886a-0da787cd689b', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f17b0177-fa6a-44b4-8f48-6cefcd1980b1', 'bbf8bd93-9fd9-4c7c-886a-0da787cd689b', '20df67be-f474-4dc3-85c4-74bedb3268b2') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1660a5e2-101d-435e-8e24-404897ebc1e3', 'd16e1afb-d4af-43ae-8e92-8dc11d9cb017', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('165ba1be-3a73-4fc9-a0d9-daa9bb3cd317', 'd16e1afb-d4af-43ae-8e92-8dc11d9cb017', 'c323bcf6-7a17-446d-8ecd-42cbba0304ed') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4a5b87ef-7c05-4a52-ac6e-56f4705e837a', 'd16e1afb-d4af-43ae-8e92-8dc11d9cb017', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('eb8fde39-473a-4e92-9b29-2e6eb4baf828', 'd16e1afb-d4af-43ae-8e92-8dc11d9cb017', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (plant_id, design_id) DO NOTHING;

-- Projects Inserts
INSERT INTO projects (id, project_name, user_id) VALUES ('42753b33-dc7e-4550-b450-5d5b53e54f88', 'BackyardForest', 'c52bd3d6-a3b4-460f-a120-f81bdda20a93') ON CONFLICT (id) DO NOTHING;

-- Layouts Inserts
INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id) VALUES (
  '6f1396fb-43b2-4384-b002-a96f578e4f4e',
  'newBeginnings',
  10,
  10,
  '77897494-c08d-4ffb-898e-d5768a4f0311',
  '42753b33-dc7e-4550-b450-5d5b53e54f88'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id) VALUES (
  'c209e9e9-eca2-4ba5-b225-2110f705045b',
  'FernForest',
  12,
  6,
  '285491c8-23d5-41cb-ac5e-4f6b84ae4d54',
  '42753b33-dc7e-4550-b450-5d5b53e54f88'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO layouts (id, layout_name, bed_length, bed_depth, design_type, projects_id) VALUES (
  '33eb20bb-8574-478a-81f3-e156d339b043',
  'AbsoluteSucculent',
  15,
  10,
  '85093f35-1ecb-458e-b89f-5c01d5d4d029',
  '42753b33-dc7e-4550-b450-5d5b53e54f88'
) ON CONFLICT (id) DO NOTHING;


-- Favorite Plants Inserts
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('63e82643-74b8-40d8-a683-43e792b23aba', 'c52bd3d6-a3b4-460f-a120-f81bdda20a93', 'e485742d-3ca0-4a3c-88f6-616d09efe7b9') ON CONFLICT (user_id, plant_id) DO NOTHING;
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('0fb54b23-484f-400e-ae62-048e1b1a5716', '3f20c4f3-8aef-4304-a6e9-e41e2dbbbfde', '1a07378f-6312-492d-bccc-57716f87efb2') ON CONFLICT (user_id, plant_id) DO NOTHING;
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('e51572ee-9ea4-4867-b51e-350f4cc1dc76', '63cdffc5-c712-45bd-b84f-2ff2444ed6ac', '24e37bfe-74b1-4f13-af5a-43acab094dc5') ON CONFLICT (user_id, plant_id) DO NOTHING;
INSERT INTO favorite_plants (id, user_id, plant_id) VALUES ('b3cf9069-1f64-489d-806c-2d108edae0e2', '2ffcea13-bd4e-437f-96f6-cbedc1b04063', '1a07378f-6312-492d-bccc-57716f87efb2') ON CONFLICT (user_id, plant_id) DO NOTHING;

-- Plant Layout Inserts
INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height) VALUES (
  '95267c78-096b-4442-861d-aa5cf0b441b4',
  'e485742d-3ca0-4a3c-88f6-616d09efe7b9',
  '6f1396fb-43b2-4384-b002-a96f578e4f4e',
  2,
  3,
  1.00,
  1.00
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height) VALUES (
  '2ffa3647-716f-45f2-a2ed-530287372678',
  '1a07378f-6312-492d-bccc-57716f87efb2',
  'c209e9e9-eca2-4ba5-b225-2110f705045b',
  15,
  7,
  3.00,
  2.00
) ON CONFLICT (id) DO NOTHING;

INSERT INTO plant_layout (id, plant_id, layout_id, x_coord, y_coord, diameter, height) VALUES (
  '9ed57ec5-b960-476f-9fc7-acc06832cfac',
  '24e37bfe-74b1-4f13-af5a-43acab094dc5',
  '33eb20bb-8574-478a-81f3-e156d339b043',
  10,
  5,
  2.00,
  2.00
) ON CONFLICT (id) DO NOTHING;


-- Fave Designs Inserts
INSERT INTO fave_design (id, user_id, design_id) VALUES ('123e192a-e06f-4fd0-8560-55d66e14c934', '3f20c4f3-8aef-4304-a6e9-e41e2dbbbfde', '285491c8-23d5-41cb-ac5e-4f6b84ae4d54') ON CONFLICT (id) DO NOTHING;
INSERT INTO fave_design (id, user_id, design_id) VALUES ('47bbe1e3-aeb0-4953-b6bd-e3a750913129', '63cdffc5-c712-45bd-b84f-2ff2444ed6ac', '85093f35-1ecb-458e-b89f-5c01d5d4d029') ON CONFLICT (id) DO NOTHING;
INSERT INTO fave_design (id, user_id, design_id) VALUES ('deef2ab5-5f7f-4561-9352-fdadd8ae05e3', '2ffcea13-bd4e-437f-96f6-cbedc1b04063', '77897494-c08d-4ffb-898e-d5768a4f0311') ON CONFLICT (id) DO NOTHING;

