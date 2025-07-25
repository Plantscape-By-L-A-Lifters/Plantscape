-- SQL SEED File generated on 2025-07-24T23:39:31.093Z

-- Designs Inserts
INSERT INTO designs (id, design_style_name, design_attributes) VALUES (
  'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0',
  'modern',
  'a modern aesthetic garden emphasizes clean lines, '
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes) VALUES (
  'eb797154-a0e8-41af-b268-57115a4f519f',
  'modern lush',
  NULL
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes) VALUES (
  '700f8c75-cc77-440b-9476-ef77eb13141e',
  'modern minimalism',
  'modern + white space, singular focal points, sparc'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes) VALUES (
  '316a9476-0baf-46f7-b2ab-4a8958efe88d',
  'naturalistic (prairie)',
  'naturalistic + balanced density + full-sun'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes) VALUES (
  '1463c44e-1ecc-4019-b343-45b3a79b74df',
  'naturalistic (woodland)',
  'naturalistic + balanced density + full-shade'
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes) VALUES (
  'd379f2d5-cf59-40f4-ba21-9bba2e02b53c',
  'classical',
  NULL
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes) VALUES (
  '0e7c0a85-97b8-4935-8c2d-26b2a5793baa',
  'cottage',
  NULL
) ON CONFLICT (id) DO NOTHING;

INSERT INTO designs (id, design_style_name, design_attributes) VALUES (
  'eff1a898-a9a2-4730-8465-47ab590d920d',
  'naturalistic',
  NULL
) ON CONFLICT (id) DO NOTHING;

-- Plants Inserts
INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'fedc074f-4b74-4b4f-81c8-185c9e5a7b6c',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('499f78e1-c359-414d-a0dd-7768a3a46a68', 'fedc074f-4b74-4b4f-81c8-185c9e5a7b6c', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4b84986b-7755-4b72-a7b7-f4f27c391a3c', 'fedc074f-4b74-4b4f-81c8-185c9e5a7b6c', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3c67ff2a-d385-4b69-b004-918e20de33dd', 'fedc074f-4b74-4b4f-81c8-185c9e5a7b6c', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '7457c24e-4783-4587-9cac-804a17136a69',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8f366443-786a-4fdf-a74a-a77ae7b1bfdb', '7457c24e-4783-4587-9cac-804a17136a69', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('00e6a20e-88b4-4b6e-ab80-4eb26be20776', '7457c24e-4783-4587-9cac-804a17136a69', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('aa747b40-966f-4bc5-8935-6c2b4ba2119f', '7457c24e-4783-4587-9cac-804a17136a69', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('508f98a2-575b-42b1-80e2-1fdfe8c9d14e', '7457c24e-4783-4587-9cac-804a17136a69', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'b7110dde-6245-451d-9f65-c03a9d9b0153',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f4c268f8-734a-425a-bbdc-72e0b38fe3a9', 'b7110dde-6245-451d-9f65-c03a9d9b0153', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('60db759a-280e-40c0-b193-eec127e395cd', 'b7110dde-6245-451d-9f65-c03a9d9b0153', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'd7801921-ab85-4443-9d51-f41810b5b16d',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7620dc28-3e80-493e-a22c-f7829c92d72c', 'd7801921-ab85-4443-9d51-f41810b5b16d', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bb35a374-ff3d-48a9-9666-53c55a899c02', 'd7801921-ab85-4443-9d51-f41810b5b16d', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('efcb431b-b590-45e8-b4a3-8d8dc7fe9ec1', 'd7801921-ab85-4443-9d51-f41810b5b16d', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '5c6af097-b91e-4fbe-97d6-1cbfe99b3a43',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8f3affd3-e1c5-43f1-9701-6d178ea8ddb5', '5c6af097-b91e-4fbe-97d6-1cbfe99b3a43', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3e1f2748-5d8e-4794-bc8e-3a33366b8f6a', '5c6af097-b91e-4fbe-97d6-1cbfe99b3a43', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '266bb529-bb58-4343-aece-676446c24999',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a5a0ebfe-9cd0-4659-b7bc-59adc0d49eaa', '266bb529-bb58-4343-aece-676446c24999', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b882bddc-b1e1-4a5d-87de-e9b0ebc23650', '266bb529-bb58-4343-aece-676446c24999', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b40c1dbd-9588-4c74-bf64-116f073bb0a3', '266bb529-bb58-4343-aece-676446c24999', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '1816d89d-3775-478d-94b9-503f3ba9782a',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0276182c-9a29-42d0-a923-b81ce07d3e39', '1816d89d-3775-478d-94b9-503f3ba9782a', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5f4f4745-be89-411c-b146-571c11e12ad3', '1816d89d-3775-478d-94b9-503f3ba9782a', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('52d2cb1f-311e-457e-8a2c-31e0f59d5461', '1816d89d-3775-478d-94b9-503f3ba9782a', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '0426481f-3f15-46a5-bcc1-3df223f7d800',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5e34758a-f755-4c0e-b325-827e0d96594c', '0426481f-3f15-46a5-bcc1-3df223f7d800', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('30c5d1f5-0486-43d1-84d9-20866f4510dc', '0426481f-3f15-46a5-bcc1-3df223f7d800', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a9a2903c-ed66-4428-ac70-888566718a97', '0426481f-3f15-46a5-bcc1-3df223f7d800', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a6bf9b6c-344c-4a99-9a50-56da1dbaf910', '0426481f-3f15-46a5-bcc1-3df223f7d800', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '0f76306c-4d75-454d-b4a3-841015866643',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a350f2e7-65c7-43b5-9918-9d0aa1c22f96', '0f76306c-4d75-454d-b4a3-841015866643', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3b42a05d-cded-4fc9-9198-a93348a38183', '0f76306c-4d75-454d-b4a3-841015866643', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '9db8063e-27f6-486d-9500-b4abdfaee40e',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6ab51d99-2917-426b-8c02-a76d132beceb', '9db8063e-27f6-486d-9500-b4abdfaee40e', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '070045fc-95d9-47ab-b56d-626e6623697b',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2101db53-e15a-4a39-9d73-13e2fec59c44', '070045fc-95d9-47ab-b56d-626e6623697b', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bed60083-7b79-4884-b174-6861acba91c8', '070045fc-95d9-47ab-b56d-626e6623697b', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1c266d43-be1b-4970-96e6-653a8f8a9a12', '070045fc-95d9-47ab-b56d-626e6623697b', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0f243cab-6424-42f5-be88-501b51b3f5ea', '070045fc-95d9-47ab-b56d-626e6623697b', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '55062b9b-a0b3-4234-a767-6fbbbe503a84',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('078e6d8b-e85b-467a-b5f9-cfe7a21b4698', '55062b9b-a0b3-4234-a767-6fbbbe503a84', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f5746489-570b-4c01-8142-eda690a6943b', '55062b9b-a0b3-4234-a767-6fbbbe503a84', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9cb860d0-60cb-49ab-b6c5-dea0f86b1231', '55062b9b-a0b3-4234-a767-6fbbbe503a84', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '4a082b1e-a4e0-4caa-bbe7-7e2fdc9dbffe',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('1fb5b117-d396-425e-8b92-99b2a3bc17c4', '4a082b1e-a4e0-4caa-bbe7-7e2fdc9dbffe', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('87685022-fcbc-4e44-85db-88558f269f92', '4a082b1e-a4e0-4caa-bbe7-7e2fdc9dbffe', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('143add05-9088-47d1-a02f-a940f7719de8', '4a082b1e-a4e0-4caa-bbe7-7e2fdc9dbffe', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f792868b-a333-445b-a188-c217732ce33a', '4a082b1e-a4e0-4caa-bbe7-7e2fdc9dbffe', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'c56ea356-be02-4791-bfc4-304f6d50b536',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('77405b8a-7ac4-4617-bcfd-c0e151b2493d', 'c56ea356-be02-4791-bfc4-304f6d50b536', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('c9de5ab7-02f3-47f3-b955-9a3a7d6f607a', 'c56ea356-be02-4791-bfc4-304f6d50b536', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('52a06a13-ffbf-4b76-b0a0-203b515d21c3', 'c56ea356-be02-4791-bfc4-304f6d50b536', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('98e53f56-7751-427d-b74b-1e8cadff13f7', 'c56ea356-be02-4791-bfc4-304f6d50b536', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f887b0fc-229a-4751-9eb5-4cc1843b6f57',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6cccaba8-7136-41c3-a702-575f0879a62e', 'f887b0fc-229a-4751-9eb5-4cc1843b6f57', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('81270014-8b96-4c39-aa8a-cd5daf9142ba', 'f887b0fc-229a-4751-9eb5-4cc1843b6f57', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a6ab4714-d044-4442-9bb2-7a91db8d34e7', 'f887b0fc-229a-4751-9eb5-4cc1843b6f57', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f8c53085-2d4a-4295-8406-f0623133e3f4',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3e39aa5f-f46a-4e1e-9a7a-bdc0064f211b', 'f8c53085-2d4a-4295-8406-f0623133e3f4', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d49cc7b7-f46a-4c8e-8673-dccb74fb66d5', 'f8c53085-2d4a-4295-8406-f0623133e3f4', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a4b0c3cc-e545-407d-833f-b3f275b75d94', 'f8c53085-2d4a-4295-8406-f0623133e3f4', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('e7b01ca8-055e-482b-b696-9a75d688db26', 'f8c53085-2d4a-4295-8406-f0623133e3f4', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '682e53df-8992-49c2-84fd-f8caa4a29d0d',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ae09f2bd-7c4a-4aaa-9be0-8c3ae8efa10a', '682e53df-8992-49c2-84fd-f8caa4a29d0d', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('96796c41-fe11-4478-8108-609b543f79e1', '682e53df-8992-49c2-84fd-f8caa4a29d0d', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('56efee08-7044-4703-af1d-7461249fc70d', '682e53df-8992-49c2-84fd-f8caa4a29d0d', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '7b2fe171-685a-4749-a715-b959157f4ef4',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('84f7a3fa-d5ba-4420-af3d-5717a2d65486', '7b2fe171-685a-4749-a715-b959157f4ef4', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fd5f7f46-01b2-43a9-85dc-c73d86799ff5', '7b2fe171-685a-4749-a715-b959157f4ef4', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('02dbace5-e7a8-4872-ae30-b41ba066c1de', '7b2fe171-685a-4749-a715-b959157f4ef4', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'c6ce1656-9c58-4326-817a-e86e85b51d01',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('95606a98-9b97-4466-93fd-b3c808bf8864', 'c6ce1656-9c58-4326-817a-e86e85b51d01', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8169065a-6efa-472e-9ca3-bd3a042f2ef2', 'c6ce1656-9c58-4326-817a-e86e85b51d01', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b2e4dc3f-8902-48d2-bfa0-f1f28dc11d46', 'c6ce1656-9c58-4326-817a-e86e85b51d01', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('715c4f97-2985-4af9-9f67-53a1ddcf3b36', 'c6ce1656-9c58-4326-817a-e86e85b51d01', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '4491cbfa-738c-4a9c-9bf9-67c1ce25f37b',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0d9a1473-3881-4f35-ae80-50ac51bf80aa', '4491cbfa-738c-4a9c-9bf9-67c1ce25f37b', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ae2ca3c9-9f96-40bf-8614-5d3a9ea3e9b1', '4491cbfa-738c-4a9c-9bf9-67c1ce25f37b', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f4a7d004-3c1c-40da-b00e-5bf4150285d4',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('98461b00-68db-40fc-891e-55fbf8947659', 'f4a7d004-3c1c-40da-b00e-5bf4150285d4', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('05fb6752-b80d-4a2a-84ed-bf9562a099c3', 'f4a7d004-3c1c-40da-b00e-5bf4150285d4', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a2207fae-ca85-490d-8517-4a3afde66140', 'f4a7d004-3c1c-40da-b00e-5bf4150285d4', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('49bdb5d2-0eb7-4c7e-8a06-a29063cf0710', 'f4a7d004-3c1c-40da-b00e-5bf4150285d4', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'a48918b3-5e69-4579-a382-eab192ad409d',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2d13a9b2-fe3d-4db9-a4ac-d4a50664d4cf', 'a48918b3-5e69-4579-a382-eab192ad409d', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('3663f6e8-6180-4977-a7f7-709b9dcd1128', 'a48918b3-5e69-4579-a382-eab192ad409d', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ceaf746b-572a-4822-b18a-89c2d4683d47', 'a48918b3-5e69-4579-a382-eab192ad409d', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '16a0985c-2809-448e-bd97-1d0175b9f2a9',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('53d5a6bd-991b-4546-a850-f907045d0556', '16a0985c-2809-448e-bd97-1d0175b9f2a9', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('4e87d79d-619d-4a39-8d88-3cbd0b546564', '16a0985c-2809-448e-bd97-1d0175b9f2a9', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9121bdd4-2677-4a6a-af02-328223966546', '16a0985c-2809-448e-bd97-1d0175b9f2a9', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9687ddaf-b443-4f6c-bbdb-ac9ed850edc2', '16a0985c-2809-448e-bd97-1d0175b9f2a9', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'f86eae3b-e265-457a-a673-14c089d3baf2',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d2a435d0-d19a-4258-a389-4595e021897c', 'f86eae3b-e265-457a-a673-14c089d3baf2', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7ee9d11d-cd62-419d-9620-ce52818a0fc6', 'f86eae3b-e265-457a-a673-14c089d3baf2', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('0f42aa4d-c201-4545-9028-91d220091044', 'f86eae3b-e265-457a-a673-14c089d3baf2', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '50cd7cf7-58ac-487b-9816-334d526980a3',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('142652da-accd-4867-9fe7-d3b06edf1be1', '50cd7cf7-58ac-487b-9816-334d526980a3', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('29cdf960-1ccf-4c21-9025-5da61b9fff7b', '50cd7cf7-58ac-487b-9816-334d526980a3', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5245ca0e-9672-4e0e-9f3e-34f4babd26b8', '50cd7cf7-58ac-487b-9816-334d526980a3', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9989860b-f679-4b67-99d2-867c2d5483e5', '50cd7cf7-58ac-487b-9816-334d526980a3', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '4b2d8785-ba4e-404a-8faf-ea11982c20c2',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f80593bd-4b74-4c05-8a02-562696687bef', '4b2d8785-ba4e-404a-8faf-ea11982c20c2', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f2bfe9be-1633-4c57-a3cc-4afd6e9b1539', '4b2d8785-ba4e-404a-8faf-ea11982c20c2', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9af14a5d-da1c-4880-8728-bf5ee8350587', '4b2d8785-ba4e-404a-8faf-ea11982c20c2', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'e2addc4e-2e82-4b58-b33d-d6e838e5ad8c',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('f04d7472-f0e6-4a14-9bbf-1f394ca0f0cb', 'e2addc4e-2e82-4b58-b33d-d6e838e5ad8c', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('77486682-67d0-462d-b0c2-bdad6196f260', 'e2addc4e-2e82-4b58-b33d-d6e838e5ad8c', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6ce175fa-68ff-40ae-a8fd-c90c70b5e61a', 'e2addc4e-2e82-4b58-b33d-d6e838e5ad8c', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '8f413de5-f5ad-4602-bf13-994ca5d1e6ac',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ec2a9c3c-0977-4464-982a-1861eac4358d', '8f413de5-f5ad-4602-bf13-994ca5d1e6ac', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7638abc6-a22b-48e7-8792-d026036c9ab8', '8f413de5-f5ad-4602-bf13-994ca5d1e6ac', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('87864c26-2d3a-4fbf-bcde-a2d659812f44', '8f413de5-f5ad-4602-bf13-994ca5d1e6ac', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5bab3cc4-a333-4d5a-b51c-98c598a2e326', '8f413de5-f5ad-4602-bf13-994ca5d1e6ac', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '905c4e4b-882f-4f53-82ad-772b696232a2',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('832195b8-b187-4d2f-8125-0910ed62841c', '905c4e4b-882f-4f53-82ad-772b696232a2', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('efe0c172-188b-4a10-a56d-212c37f48dd5', '905c4e4b-882f-4f53-82ad-772b696232a2', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d24f1b11-78f7-415e-ba78-a4f70814d438', '905c4e4b-882f-4f53-82ad-772b696232a2', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('d437f6eb-c2e1-4ec2-8ece-cd77f46fa0e0', '905c4e4b-882f-4f53-82ad-772b696232a2', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '5fe945e8-dc8c-41b7-b12f-b9e62139f93c',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('b77cdcf7-ab12-4db6-af69-721151f2781a', '5fe945e8-dc8c-41b7-b12f-b9e62139f93c', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7c7f655e-15ce-4a19-8260-fc63164e9868', '5fe945e8-dc8c-41b7-b12f-b9e62139f93c', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('42aeed5a-30c5-4bab-98d0-5e7cb638e627', '5fe945e8-dc8c-41b7-b12f-b9e62139f93c', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('539eb03c-f718-400b-996d-c07a2d2624d5', '5fe945e8-dc8c-41b7-b12f-b9e62139f93c', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '5d8e3257-aa8e-4e5d-b03a-50c2f154936f',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('6ff3ddd6-9cec-4e58-9fad-7a5b1cd1e478', '5d8e3257-aa8e-4e5d-b03a-50c2f154936f', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('fb5dd285-1d47-4235-844b-7417fa2b4135', '5d8e3257-aa8e-4e5d-b03a-50c2f154936f', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ad9e5298-d8ad-4f44-a772-436151979880', '5d8e3257-aa8e-4e5d-b03a-50c2f154936f', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '85068847-c0f3-4506-8356-ab471dc570fa',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2681b1d3-01a9-4521-9460-1e4dbcaeea9e', '85068847-c0f3-4506-8356-ab471dc570fa', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7db81603-c324-41c3-9553-ecdf0d82f655', '85068847-c0f3-4506-8356-ab471dc570fa', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2c1fbc96-80cd-4889-a9be-fbb58317f054', '85068847-c0f3-4506-8356-ab471dc570fa', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8a40243e-75ee-4543-8bf1-c7bec4980f67', '85068847-c0f3-4506-8356-ab471dc570fa', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'bbd7dc5b-fda4-44e6-81e3-8e8fff94ea84',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('939d2894-8402-45ab-b701-07c6ad8ce76b', 'bbd7dc5b-fda4-44e6-81e3-8e8fff94ea84', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('5002c416-b406-410f-8426-3e67548e268d', 'bbd7dc5b-fda4-44e6-81e3-8e8fff94ea84', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bbe82c0f-546b-4228-aa82-873fcc7c5490', 'bbd7dc5b-fda4-44e6-81e3-8e8fff94ea84', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  '48a0c00b-613f-41ba-9ddb-7d9887a5d29a',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2b274b6b-9a35-407a-a03e-0726a15c6658', '48a0c00b-613f-41ba-9ddb-7d9887a5d29a', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('99cca1e5-d1ab-4703-96cc-1615792ec605', '48a0c00b-613f-41ba-9ddb-7d9887a5d29a', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('ec0ec088-d49e-4cd2-9110-fee6098c1241', '48a0c00b-613f-41ba-9ddb-7d9887a5d29a', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'ef9b9e27-c44a-407c-9597-54daf4f0d7b7',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('bd77b980-efc1-4042-8395-09faaf73283e', 'ef9b9e27-c44a-407c-9597-54daf4f0d7b7', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8f6b9687-0b46-4f86-91b8-502fd304483c', 'ef9b9e27-c44a-407c-9597-54daf4f0d7b7', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('8f671e58-944f-4a3e-b802-0d7557036075', 'ef9b9e27-c44a-407c-9597-54daf4f0d7b7', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('a1b57af5-30cd-4527-8dd0-50ebc63619ed', 'ef9b9e27-c44a-407c-9597-54daf4f0d7b7', 'd379f2d5-cf59-40f4-ba21-9bba2e02b53c') ON CONFLICT (plant_id, design_id) DO NOTHING;

INSERT INTO plants (id, plant_name, other_common_names, technical_name, growth_form, is_toxic, sun_requirements, height_min_ft, height_max_ft, width_min_ft, width_max_ft, seasonal_interest, primary_color, accent_color, image_url) VALUES (
  'a0416d18-ab69-4a5a-8c5f-5aef8be1628f',
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

INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('7a277f95-0213-4375-919b-fd3a348dd8e1', 'a0416d18-ab69-4a5a-8c5f-5aef8be1628f', 'c3dba5fd-fcbe-4f5e-bc3f-d4c85614f8e0') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('9156a748-143c-4590-9d25-8529f6104fef', 'a0416d18-ab69-4a5a-8c5f-5aef8be1628f', 'eff1a898-a9a2-4730-8465-47ab590d920d') ON CONFLICT (plant_id, design_id) DO NOTHING;
INSERT INTO plant_Design_Types (id, plant_id, design_id) VALUES ('2b9561bf-0ecb-4885-82cc-2b5ad0594e66', 'a0416d18-ab69-4a5a-8c5f-5aef8be1628f', '0e7c0a85-97b8-4935-8c2d-26b2a5793baa') ON CONFLICT (plant_id, design_id) DO NOTHING;

