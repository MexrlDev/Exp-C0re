--[[
    Example Web Controller
    Based on original work by EgyDevTeam
]]--

-- Raw Hex (from bin)
local sc = "41 57 48 8D 87 A9 1A 03 00 49 89 D0 48 89 F9 41 56 41 55 49 89 F5 41 54 55 53 48 89 D3 48 89 F2 48 81 EC 18 01 00 00 48 89 04 24 48 8D 44 24 28 48 8B 34 24 48 89 C7 48 89 44 24 10 E8 D0 03 00 00 85 C0 74 14 48 C7 03 FF FF FF FF 48 C7 43 08 01 00 00 00 E9 0E 03 00 00 48 8B BC 24 80 00 00 00 BE 00 00 00 FF 89 C5 E8 C9 0A 00 00 48 8B BC 24 88 00 00 00 BE 00 00 00 FF E8 B7 0A 00 00 48 8B 3C 24 BA 01 20 00 00 4C 89 EE 48 8D 0D 06 0F 00 00 E8 05 03 00 00 6A 00 45 31 C9 45 31 C0 6A 00 48 8B 7C 24 10 48 89 C6 31 C9 48 8D 15 FF 0E 00 00 E8 C2 02 00 00 48 8B 7C 24 10 48 8D 0D FD 0E 00 00 4C 89 EE 89 C2 41 89 C6 E8 CC 02 00 00 48 8B 7C 24 10 44 89 F2 4C 89 EE 48 8D 0D E9 0E 00 00 49 89 C4 E8 B2 02 00 00 48 8B 7C 24 10 44 89 F2 4C 89 EE 48 8D 0D DF 0E 00 00 49 89 C7 E8 98 02 00 00 49 89 C6 58 5A 4D 85 E4 74 1F 6A 00 45 31 C9 45 31 C0 31 C9 6A 00 48 8B 7C 24 10 31 D2 4C 89 E6 E8 50 02 00 00 41 5A 41 5B 41 83 CC FF 4D 85 FF 74 24 48 8B 53 48 6A 00 45 31 C9 45 31 C0 6A 00 48 8B 7C 24 10 31 C9 4C 89 FE E8 26 02 00 00 41 58 41 59 41 89 C4 48 8B 3C 24 4C 89 EE BA 01 20 00 00 45 31 FF 48 8D 0D 76 0E 00 00 E8 27 02 00 00 49 89 C5 44 89 E0 F7 D0 C1 E8 1F 89 44 24 18 80 7C 24 18 00 74 41 4D 85 F6 74 3C 48 8D BC 24 90 00 00 00 31 C0 4C 89 F6 49 63 D4 B9 20 00 00 00 45 31 C9 41 B8 01 00 00 00 F3 AB 48 8D 8C 24 90 00 00 00 6A 00 6A 00 48 8B 7C 24 10 E8 B3 01 00 00 5E 5F 85 C0 7F 04 31 C0 EB 70 8B 94 24 90 00 00 00 85 D2 78 F1 89 D0 C1 E8 0E 83 E0 01 0F BA E2 0F 73 03 83 C8 02 0F BA E2 0C 73 03 83 C8 04 0F BA E2 0D 73 03 83 C8 08 F6 C2 08 74 03 83 C8 08 F6 C2 10 74 03 83 C8 10 F6 C2 40 74 03 83 C8 20 F6 C2 80 74 03 83 C8 40 F6 C2 20 74 03 83 C8 80 F6 C6 04 B1 FE 0F 45 C1 0F BA E2 0B 0F 82 14 01 00 00 3C FF 0F 84 0C 01 00 00 48 63 D5 88 44 24 1F BE 00 00 00 FF 48 8B 84 D4 80 00 00 00 48 89 C7 48 89 44 24 08 E8 D5 08 00 00 48 8B 7C 24 08 41 B8 90 01 00 00 83 C9 FF BA 04 00 00 00 48 8D 35 7B 0D 00 00 E8 E1 09 00 00 48 8B 7C 24 08 41 B8 F4 01 00 00 B9 00 AA FF FF BA 04 00 00 00 48 8D 35 6B 0D 00 00 E8 C0 09 00 00 8A 44 24 1F 84 C0 74 63 89 C2 48 8D 0D 6E 0D 00 00 83 E0 0F 48 8B 7C 24 08 C0 EA 04 8A 04 01 41 B8 00 FF 00 FF BE 32 00 00 00 0F B6 D2 C6 84 24 94 00 00 00 20 8A 14 11 48 8D 8C 24 90 00 00 00 C7 84 24 90 00 00 00 50 61 64 3A 88 84 24 96 00 00 00 88 94 24 95 00 00 00 BA E8 03 00 00 C6 84 24 97 00 00 00 00 E8 EA 08 00 00 48 8B 7C 24 10 89 EE 41 FF C7 83 F5 01 E8 88 07 00 00 4D 85 ED 0F 84 5D FE FF FF 6A 00 31 C9 BA 1B 41 00 00 45 31 C9 6A 00 48 8B 7C 24 10 45 31 C0 4C 89 EE E8 34 00 00 00 5A 59 E9 38 FE FF FF 48 8B 7C 24 10 E8 2D 06 00 00 31 C0 44 89 7B 10 48 89 03 48 C7 43 08 63 00 00 00 48 81 C4 18 01 00 00 5B 5D 41 5C 41 5D 41 5E 41 5F C3 53 48 89 F3 48 89 F8 48 89 D7 48 89 CE 4C 89 C2 4C 89 C9 4C 8B 44 24 10 4C 8B 4C 24 18 FF D0 5B C3 0F 0B 48 83 EC 18 31 C0 48 63 D2 45 31 C9 48 89 44 24 08 6A 00 6A 00 4C 8D 44 24 18 E8 BE FF FF FF 48 8B 44 24 18 48 83 C4 28 C3 53 48 89 F3 48 89 F8 48 89 D7 48 89 CE 4C 89 C2 4C 89 C9 4C 8B 44 24 10 4C 8B 4C 24 18 FF D0 5B C3 0F 0B 48 83 EC 18 31 C0 48 63 D2 45 31 C9 48 89 44 24 08 6A 00 6A 00 4C 8D 44 24 18 E8 BE FF FF FF 48 8B 44 24 18 48 83 C4 28 C3 41 57 45 31 C9 48 89 D0 49 89 CF 41 56 48 8D 0D C1 0B 00 00 41 55 41 54 55 53 48 89 FB 48 81 EC 88 00 00 00 4C 89 4F 48 4C 89 4F 50 4C 89 4F 60 4C 89 4F 58 48 89 37 48 89 57 08 C7 47 40 FF FF FF FF 48 89 34 24 48 8B 3C 24 48 89 C6 48 89 54 24 08 BA 01 20 00 00 E8 7B FF FF FF 48 8B 74 24 08 48 8B 3C 24 48 8D 0D B4 0B 00 00 BA 01 20 00 00 49 89 C4 E8 5E FF FF FF 48 8B 74 24 08 48 8B 3C 24 48 8D 0D FE 0A 00 00 BA 01 20 00 00 48 89 44 24 28 E8 3F FF FF FF 48 8B 74 24 08 48 8B 3C 24 48 8D 0D 89 0B 00 00 BA 01 20 00 00 48 89 C5 E8 22 FF FF FF 48 8B 74 24 08 48 8B 3C 24 48 8D 0D 8A 0B 00 00 BA 01 20 00 00 48 89 44 24 10 E8 03 FF FF FF 48 8B 74 24 08 48 8B 3C 24 48 8D 0D 84 0B 00 00 BA 01 20 00 00 48 89 44 24 18 E8 E4 FE FF FF 48 8B 74 24 08 48 8B 3C 24 48 8D 0D 82 0B 00 00 BA 01 20 00 00 49 89 C5 E8 C7 FE FF FF 48 8B 74 24 08 48 8B 3C 24 48 8D 0D 7B 0B 00 00 BA 01 20 00 00 49 89 C6 E8 AA FE FF FF 48 89 44 24 20 4D 85 E4 0F 84 22 04 00 00 48 85 ED 0F 84 19 04 00 00 48 83 7C 24 10 00 0F 84 0D 04 00 00 48 83 7C 24 18 00 0F 84 01 04 00 00 4C 8B 5C 24 28 4D 85 DB 74 28 49 8B 97 B0 89 7F 05 48 85 D2 74 1C 6A 00 45 31 C0 45 31 C9 31 C9 6A 00 48 8B 7C 24 10 4C 89 DE E8 29 FE FF FF 5F 41 58 6A 00 45 31 C9 45 31 C0 31 C9 6A 00 48 8B 7C 24 10 BA E0 93 04 00 4C 89 E6 E8 08 FE FF FF 6A 00 48 8D 15 FC 0A 00 00 31 C9 6A 00 48 8B 7C 24 20 48 89 EE 45 31 C9 45 31 C0 E8 E8 FD FF FF 48 83 C4 20 48 89 C2 89 C5 B8 FE FF FF FF 85 D2 0F 88 7E 03 00 00 48 8B 74 24 08 48 8B 3C 24 48 8D 0D D3 0A 00 00 E8 E0 FD FF FF 48 8B 74 24 08 48 8B 3C 24 89 EA 48 89 43 10 48 8D 0D C8 0A 00 00 E8 C5 FD FF FF 48 8B 74 24 08 48 8B 3C 24 89 EA 48 89 43 18 48 8D 0D BE 0A 00 00 E8 AA FD FF FF 48 8B 74 24 08 48 8B 3C 24 89 EA 48 89 43 20 48 8D 0D BE 0A 00 00 E8 8F FD FF FF 48 8B 74 24 08 48 8B 3C 24 89 EA 48 89 43 28 48 8D 0D B9 0A 00 00 E8 74 FD FF FF 48 8B 74 24 08 48 8B 3C 24 89 EA 48 89 43 30 48 8D 0D B5 0A 00 00 E8 59 FD FF FF 48 83 7B 10 00 48 89 43 38 B8 FD FF FF FF 0F 84 CE 02 00 00 48 8B 73 18 48 85 F6 0F 84 C1 02 00 00 48 83 7B 20 00 0F 84 B6 02 00 00 48 83 7B 28 00 0F 84 AB 02 00 00 49 63 97 D0 95 D6 02 85 D2 78 18 6A 00 31 C9 45 31 C9 45 31 C0 6A 00 48 8B 7C 24 10 E8 DE FC FF FF 59 5E 6A 00 45 31 C9 45 31 C0 31 C9 6A 00 48 8B 7C 24 10 BA A0 86 01 00 4C 89 E6 E8 BE FC FF FF 48 8B 73 10 6A 00 BA FF 00 00 00 6A 00 48 8B 7C 24 20 45 31 C9 45 31 C0 31 C9 E8 9F FC FF FF 48 83 C4 20 48 89 C2 89 43 40 B8 FC FF FF FF 85 D2 0F 88 34 02 00 00 4D 85 F6 74 24 6A 00 48 8D 53 48 45 31 C9 45 31 C0 6A 00 48 8B 7C 24 10 48 8D 0D FB 09 00 00 4C 89 F6 E8 61 FC FF FF 58 5A 48 8B 73 38 48 85 F6 74 24 48 8B 53 48 48 85 D2 74 1B 48 63 4B 40 6A 00 45 31 C9 45 31 C0 6A 00 48 8B 7C 24 10 E8 35 FC FF FF 41 5F 58 B9 03 00 00 00 48 C1 E1 20 4D 85 ED 74 22 6A 00 31 C9 4C 89 EE 45 31 C9 6A 00 48 8B 7C 24 10 45 31 C0 31 D2 E8 09 FC FF FF 41 5D 41 5E 48 89 C1 48 8D 44 24 38 45 31 E4 41 B9 00 00 20 00 31 D2 4C 89 64 24 38 41 B8 00 00 00 01 50 6A 03 48 8B 74 24 20 48 8B 7C 24 10 E8 D5 FB FF FF 68 00 00 20 00 48 8D 53 50 45 31 C9 FF 74 24 50 48 8B 74 24 38 41 B8 33 00 00 00 B9 00 00 00 01 48 8B 7C 24 20 E8 AB FB FF FF 48 8B 53 50 48 83 C4 20 31 C0 48 8D B2 00 00 80 00 48 85 D2 75 60 48 8B 73 18 48 85 F6 74 1D 48 63 53 40 6A 00 45 31 C9 45 31 C0 6A 00 48 8B 7C 24 10 31 C9 E8 72 FB FF FF 41 5B 5D 48 83 7C 24 20 00 48 8B 53 48 74 24 48 85 D2 74 1F 6A 00 45 31 C9 45 31 C0 31 C9 6A 00 48 8B 74 24 30 48 8B 7C 24 10 E8 43 FB FF FF 41 59 41 5A B8 FB FF FF FF E9 E1 00 00 00 C7 04 02 00 00 00 FF C7 84 02 00 00 80 00 00 00 00 FF 48 83 C0 04 48 3D 00 90 7E 00 75 E2 48 8D 7C 24 40 31 C0 B9 10 00 00 00 48 89 53 58 F3 AB B8 03 00 00 00 48 89 73 60 48 63 53 40 48 C1 E0 1F C7 44 24 54 80 07 00 00 48 8B 73 20 4C 8D 43 58 48 89 44 24 40 41 B9 02 00 00 00 48 B8 80 07 00 00 38 04 00 00 48 89 44 24 4C 6A 00 48 8D 44 24 48 50 48 8B 7C 24 10 E8 B8 FA FF FF 5F 41 58 48 85 C0 74 27 48 8B 73 18 48 85 F6 74 49 48 63 53 40 6A 00 31 C9 45 31 C9 6A 00 48 8B 7C 24 10 45 31 C0 E8 8D FA FF FF 59 5E EB 2B 48 8B 73 30 48 85 F6 75 04 31 C0 EB 28 48 63 53 40 6A 00 45 31 C9 45 31 C0 6A 00 48 8B 7C 24 10 31 C9 E8 62 FA FF FF 58 5A EB DE B8 FA FF FF FF EB 03 83 C8 FF 48 81 C4 88 00 00 00 5B 5D 41 5C 41 5D 41 5E 41 5F C3 41 54 55 53 48 89 FB 48 8B 3F 48 85 FF 0F 84 0B 01 00 00 48 8B 73 08 48 8D 0D 45 06 00 00 BA 01 20 00 00 E8 3D FA FF FF 48 8B 73 08 48 8B 3B BA 01 20 00 00 48 8D 0D EE 06 00 00 49 89 C4 E8 22 FA FF FF 48 8B 53 58 48 89 C5 48 85 D2 74 14 31 C0 C7 04 82 00 00 00 FF 48 FF C0 48 3D 00 A4 1F 00 75 EE 48 8B 53 60 48 85 D2 74 14 31 C0 C7 04 82 00 00 00 FF 48 FF C0 48 3D 00 A4 1F 00 75 EE 48 8B 73 28 48 85 F6 74 23 48 63 53 40 85 D2 78 1B 6A 00 45 31 C9 41 B8 01 00 00 00 31 C9 6A 00 48 8B 3B E8 9A F9 FF FF 41 59 41 5A 4D 85 E4 74 1F 6A 00 45 31 C0 45 31 C9 31 C9 6A 00 48 8B 3B BA 50 C3 00 00 4C 89 E6 E8 75 F9 FF FF 5F 41 58 48 8B 73 18 48 85 F6 74 1E 48 63 53 40 85 D2 78 16 6A 00 31 C9 45 31 C9 45 31 C0 6A 00 48 8B 3B E8 4D F9 FF FF 59 5E 48 8B 53 48 48 85 ED 74 1E 48 85 D2 74 19 6A 00 45 31 C9 45 31 C0 31 C9 6A 00 48 8B 3B 48 89 EE E8 26 F9 FF FF 58 5A 5B 5D 41 5C C3 48 8B 47 28 48 85 C0 0F 84 82 00 00 00 53 48 89 FB 48 83 EC 50 48 63 57 40 85 D2 78 6C 6A 00 48 8B 3F 48 63 CE 45 31 C9 6A 00 48 89 C6 41 B8 01 00 00 00 E8 E7 F8 FF FF 48 83 7B 48 00 5E 5F 74 48 48 8B 73 08 48 8B 3B BA 01 20 00 00 48 8D 0D 62 06 00 00 E8 E9 F8 FF FF 48 89 C6 48 85 C0 74 28 31 C0 48 8D 4C 24 10 48 8B 53 48 48 8B 3B 89 44 24 0C 41 B8 01 00 00 00 6A 00 6A 00 4C 8D 4C 24 1C E8 98 F8 FF FF 5A 59 48 83 C4 50 5B C3 C3 31 C0 89 34 87 48 FF C0 48 3D 00 A4 1F 00 75 F2 C3 81 FE 70 07 00 00 0F 87 A2 00 00 00 89 D0 81 FA 28 04 00 00 0F 87 94 00 00 00 41 89 C9 44 8D 51 E0 83 E9 61 53 80 F9 19 77 05 45 89 D1 EB 0B BA 1F 00 00 00 41 80 FA 3A 77 08 41 83 E9 20 49 0F BE D1 69 C0 80 07 00 00 48 8D 0D 2A 02 00 00 41 BB 80 00 00 00 4C 8D 14 D1 31 D2 01 F0 41 0F B6 1C 12 89 C6 31 C9 45 89 D9 41 D3 F9 41 85 D9 74 23 4C 63 CE 4E 8D 0C 8F 45 89 01 45 89 41 04 44 8D 8E 80 07 00 00 4D 63 C9 4E 8D 0C 8F 45 89 01 45 89 41 04 FF C1 83 C6 02 83 F9 08 75 C8 48 FF C2 05 00 0F 00 00 48 83 FA 08 75 B1 5B C3 C3 41 54 41 89 D4 55 89 F5 53 48 89 CB 0F BE 0B 84 C9 74 12 89 EE 44 89 E2 83 C5 10 48 FF C3 E8 2E FF FF FF EB E7 5B 5D 41 5C C3 31 D2 48 89 D0 48 FF C2 80 7C 17 FF 00 75 F3 C3 49 89 F9 48 89 F7 41 89 D0 48 89 F1 E8 DF FF FF FF BE 02 00 00 00 4C 89 CF C1 E0 04 89 C2 B8 80 07 00 00 29 D0 99 F7 FE BA 14 02 00 00 89 C6 EB 95 41 57 41 56 41 55 41 54 55 53 44 89 C3 C1 EB 1F 48 83 EC 20 48 89 7C 24 08 48 89 F7 89 D6 89 4C 24 10 44 8D 0C F5 00 00 00 00 B9 02 00 00 00 E8 8B FF FF FF 89 5C 24 18 43 8D 1C 01 41 0F AF C1 89 5C 24 1C 89 C2 B8 80 07 00 00 29 D0 99 F7 F9 8A 0F 84 C9 0F 84 DB 00 00 00 85 C0 79 08 48 FF C7 44 01 C8 EB EA 41 8D 14 01 81 FA 80 07 00 00 7F EC 80 7C 24 18 00 75 E5 81 7C 24 1C 38 04 00 00 7F DB 8D 51 9F 44 8D 51 E0 80 FA 19 77 05 44 89 D1 EB 0B BA 1F 00 00 00 41 80 FA 3A 77 07 8D 51 E0 48 0F BE D2 48 8D 1D B2 00 00 00 45 31 D2 4C 8D 34 D3 44 89 C3 44 69 E3 80 07 00 00 43 0F B6 14 16 89 C5 89 54 24 14 49 63 CC 48 89 0C 24 31 C9 BA 80 00 00 00 D3 FA 85 54 24 14 75 0B FF C1 01 F5 83 F9 08 75 EA EB 3B 4C 8B 3C 24 48 63 D5 45 31 ED 4C 01 FA 44 39 EE 7E E3 4C 8B 5C 24 08 4D 8D 3C 93 45 31 DB 44 8B 64 24 10 47 89 24 9F 49 FF C3 44 39 DE 7F EF 41 FF C5 48 81 C2 80 07 00 00 EB D2 49 FF C2 01 F3 49 83 FA 08 75 87 E9 29 FF FF FF 48 83 C4 20 5B 5D 41 5C 41 5D 41 5E 41 5F C3 66 2E 0F 1F 84 00 00 00 00 00 66 2E 0F 1F 84 00 00 00 00 00 0F 1F 80 00 00 00 00 00 00 00 00 00 00 00 00 18 18 18 18 18 00 18 00 66 66 66 00 00 00 00 00 6C 6C FE 6C FE 6C 6C 00 18 3E 60 3C 06 7C 18 00 00 66 AC D8 36 6A CC 00 38 6C 38 76 DC CC 76 00 18 18 30 00 00 00 00 00 0C 18 30 30 30 18 0C 00 30 18 0C 0C 0C 18 30 00 00 66 3C FF 3C 66 00 00 00 18 18 7E 18 18 00 00 00 00 00 00 00 18 18 30 00 00 00 7E 00 00 00 00 00 00 00 00 00 18 18 00 02 04 08 10 20 40 00 00 3C 46 4A 52 62 3C 00 00 18 38 18 18 18 7E 00 00 3C 42 02 3C 40 7E 00 00 3C 42 0C 02 42 3C 00 00 08 18 28 48 7E 08 00 00 7E 40 7C 02 42 3C 00 00 1C 20 40 7C 42 3C 00 00 7E 02 04 08 10 10 00 00 3C 42 3C 42 42 3C 00 00 3C 42 3E 02 04 38 00 00 00 18 18 00 18 18 00 00 00 18 18 00 18 18 30 00 06 0C 18 30 18 0C 06 00 00 00 7E 00 7E 00 00 00 60 30 18 0C 18 30 60 00 3C 42 04 08 00 08 00 00 3C 42 5A 56 40 3C 00 00 18 24 42 7E 42 42 00 00 7C 42 7C 42 42 7C 00 00 3C 42 40 40 42 3C 00 00 78 44 42 42 44 78 00 00 7E 40 7C 40 40 7E 00 00 7E 40 7C 40 40 40 00 00 3C 42 40 4E 42 3C 00 00 42 42 7E 42 42 42 00 00 7E 18 18 18 18 7E 00 00 1E 06 06 06 46 3C 00 00 44 48 70 48 44 42 00 00 40 40 40 40 40 7E 00 00 42 66 5A 42 42 42 00 00 42 62 52 4A 46 42 00 00 3C 42 42 42 42 3C 00 00 7C 42 42 7C 40 40 00 00 3C 42 42 4A 44 3A 00 00 7C 42 42 7C 44 42 00 00 3C 40 3C 02 42 3C 00 00 7E 18 18 18 18 18 00 00 42 42 42 42 42 3C 00 00 42 42 42 42 24 18 00 00 42 42 42 5A 66 42 00 00 42 24 18 18 24 42 00 00 42 42 24 18 18 18 00 00 7E 04 08 10 20 7E 00 00 73 63 65 4B 65 72 6E 65 6C 4C 6F 61 64 53 74 61 72 74 4D 6F 64 75 6C 65 00 6C 69 62 53 63 65 50 61 64 2E 73 70 72 78 00 73 63 65 50 61 64 49 6E 69 74 00 73 63 65 50 61 64 47 65 74 48 61 6E 64 6C 65 00 73 63 65 50 61 64 52 65 61 64 00 73 63 65 4B 65 72 6E 65 6C 55 73 6C 65 65 70 00 48 65 6C 6C 6F 20 57 6F 72 6C 64 20 46 72 6F 6D 00 53 74 61 72 20 57 61 72 73 20 52 61 63 65 72 20 52 65 76 65 6E 67 65 21 00 30 31 32 33 34 35 36 37 38 39 41 42 43 44 45 46 00 73 63 65 50 74 68 72 65 61 64 43 61 6E 63 65 6C 00 73 63 65 4B 65 72 6E 65 6C 41 6C 6C 6F 63 61 74 65 44 69 72 65 63 74 4D 65 6D 6F 72 79 00 73 63 65 4B 65 72 6E 65 6C 4D 61 70 44 69 72 65 63 74 4D 65 6D 6F 72 79 00 73 63 65 4B 65 72 6E 65 6C 47 65 74 44 69 72 65 63 74 4D 65 6D 6F 72 79 53 69 7A 65 00 73 63 65 4B 65 72 6E 65 6C 43 72 65 61 74 65 45 71 75 65 75 65 00 73 63 65 4B 65 72 6E 65 6C 44 65 6C 65 74 65 45 71 75 65 75 65 00 6C 69 62 53 63 65 56 69 64 65 6F 4F 75 74 2E 73 70 72 78 00 73 63 65 56 69 64 65 6F 4F 75 74 4F 70 65 6E 00 73 63 65 56 69 64 65 6F 4F 75 74 43 6C 6F 73 65 00 73 63 65 56 69 64 65 6F 4F 75 74 52 65 67 69 73 74 65 72 42 75 66 66 65 72 73 00 73 63 65 56 69 64 65 6F 4F 75 74 53 75 62 6D 69 74 46 6C 69 70 00 73 63 65 56 69 64 65 6F 4F 75 74 53 65 74 46 6C 69 70 52 61 74 65 00 73 63 65 56 69 64 65 6F 4F 75 74 41 64 64 46 6C 69 70 45 76 65 6E 74 00 76 69 64 71 00 73 63 65 4B 65 72 6E 65 6C 57 61 69 74 45 71 75 65 75 65 00"

init_dlsym()
sceMsgDialogTerminate()

-- add pc ip here
local PC_IP    = ""
local LOG_PORT = 9027
local WEB_PORT = 9030

local function htons(p) return ((p << 8) | (p >> 8)) & 0xFFFF end
local function inet_addr(s)
    local a,b,c,d = s:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")
    return (d << 24) | (c << 16) | (b << 8) | a
end

local function make_sockaddr_in(port, ip)
    local sa = malloc(16)
    for i = 0, 15 do write8(sa + i, 0) end
    write8(sa + 0, 16); write8(sa + 1, 2)
    write16(sa + 2, htons(port))
    if ip then write32(sa + 4, inet_addr(ip)) end
    return sa
end

local log_sock = create_socket(AF_INET, SOCK_DGRAM, 0)
local log_sa = make_sockaddr_in(LOG_PORT, PC_IP)

local function ulog(m)
    if log_sock >= 0 then syscall.sendto(log_sock, m.."\n", #m+1, 0, log_sa, 16) end
end
ulog("=== Example V1.0 Web Controller ===")

if not sceKernelLoadStartModule then
    sceKernelLoadStartModule = func_wrap(dlsym(LIBKERNEL_HANDLE, "sceKernelLoadStartModule"))
end
local libUser = sceKernelLoadStartModule("libSceUserService.sprx", 0, 0, 0, 0, 0)
local getUserId = dlsym(libUser, "sceUserServiceGetInitialUser")
local uid_buf = malloc(4)
write32(uid_buf, 0)
if getUserId then func_wrap(getUserId)(uid_buf) end
local userId = read32(uid_buf)
ulog("userId=" .. tostring(userId))

local web_sock = create_socket(AF_INET, 1, 0)
if web_sock >= 0 then
    local ba = make_sockaddr_in(WEB_PORT)
    local en = malloc(4)
    write32(en, 1)
    syscall.setsockopt(web_sock, 0xFFFF, 4, en, 4)
    syscall.bind(web_sock, ba, 16)
    syscall.listen(web_sock, 128)
    ulog("Web controller on port " .. WEB_PORT)
else
    ulog("Web socket failed!")
end

local html_body = [=[
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover"
    />
    <title>Example Controller</title>
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Press+Start+2P&family=Orbitron:wght@400;700;900&display=swap");
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        -webkit-tap-highlight-color: transparent;
        touch-action: manipulation;
      }
      html,
      body {
        width: 100%;
        height: 100%;
        overflow: hidden;
        position: fixed;
      }
      body {
        background: #0a0a0f;
        font-family: "Orbitron", monospace;
        display: flex;
        align-items: center;
        justify-content: center;
        background-image:
          radial-gradient(
            ellipse at 50% 0%,
            rgba(20, 60, 120, 0.15) 0%,
            transparent 60%
          ),
          radial-gradient(
            ellipse at 50% 100%,
            rgba(120, 20, 40, 0.1) 0%,
            transparent 50%
          );
        user-select: none;
        -webkit-user-select: none;
        padding: env(safe-area-inset-top) env(safe-area-inset-right)
          env(safe-area-inset-bottom) env(safe-area-inset-left);
      }
      .controller {
        position: relative;
        width: min(96vw, 680px);
        height: min(80vh, 440px);
        background: linear-gradient(
          165deg,
          #2a2a32 0%,
          #1a1a22 40%,
          #14141c 100%
        );
        border-radius: 24px 24px 80px 80px;
        box-shadow:
          0 2px 0 #3a3a44,
          0 -1px 0 #0a0a12,
          0 20px 60px rgba(0, 0, 0, 0.8),
          inset 0 1px 0 rgba(255, 255, 255, 0.06),
          inset 0 -2px 0 rgba(0, 0, 0, 0.3);
        display: flex;
        flex-direction: column;
        padding: 16px 20px;
      }
      .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 8px 8px;
      }
      .brand {
        font-family: "Press Start 2P", monospace;
        font-size: clamp(8px, 2vw, 13px);
        color: #c8a04a;
        text-shadow: 0 0 12px rgba(200, 160, 74, 0.4);
        letter-spacing: 2px;
      }
      .screen-bar {
        background: #111;
        border-radius: 6px;
        margin: 0 20px 12px;
        padding: 6px 12px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        border: 1px solid #222;
        min-height: 28px;
        gap: 8px;
      }
      .screen-label {
        font-family: "Press Start 2P", monospace;
        font-size: clamp(6px, 1.2vw, 8px);
        color: #334;
        letter-spacing: 1px;
      }
      .hid-btn {
        font-family: "Orbitron", monospace;
        font-size: clamp(7px, 1.2vw, 9px);
        color: #4af;
        background: rgba(68, 136, 255, 0.08);
        border: 1px solid rgba(68, 136, 255, 0.25);
        border-radius: 4px;
        padding: 3px 8px;
        cursor: pointer;
        letter-spacing: 0.5px;
        white-space: nowrap;
        transition: all 0.15s;
        display: none;
      }
      .hid-btn:hover,
      .hid-btn:active {
        background: rgba(68, 136, 255, 0.18);
        border-color: rgba(68, 136, 255, 0.5);
      }
      .hid-btn.show {
        display: inline-block;
      }
      .status-wrap {
        display: flex;
        align-items: center;
        gap: 8px;
      }
      .status-dot {
        width: 7px;
        height: 7px;
        border-radius: 50%;
        background: #222;
        border: 1px solid #333;
        transition: all 0.3s;
        flex-shrink: 0;
      }
      .status-dot.on {
        background: #0f0;
        box-shadow:
          0 0 6px #0f0,
          0 0 14px rgba(0, 255, 0, 0.3);
        border-color: #0a0;
      }
      #status {
        font-family: "Orbitron", monospace;
        font-size: clamp(7px, 1.3vw, 9px);
        color: #4a8;
        text-transform: uppercase;
        letter-spacing: 1px;
      }
      .controls {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0 8px;
      }
      .dpad-wrap {
        position: relative;
        width: 170px;
        height: 170px;
        flex-shrink: 0;
      }
      .dpad {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 148px;
        height: 148px;
      }
      .dpad-bg {
        position: absolute;
        background: #111;
        border: 2px solid #222;
      }
      .dpad-h {
        top: 50%;
        left: 0;
        right: 0;
        height: 50px;
        transform: translateY(-50%);
        border-radius: 4px;
      }
      .dpad-v {
        left: 50%;
        top: 0;
        bottom: 0;
        width: 50px;
        transform: translateX(-50%);
        border-radius: 4px;
      }
      .dpad-center {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 14px;
        height: 14px;
        border-radius: 50%;
        background: #1a1a1a;
        border: 1px solid #333;
        transform: translate(-50%, -50%);
        z-index: 3;
      }
      .dpad-btn {
        position: absolute;
        z-index: 2;
        display: flex;
        align-items: center;
        justify-content: center;
        background: transparent;
        border: none;
        color: #444;
        font-size: 18px;
        cursor: pointer;
        transition:
          color 0.08s,
          transform 0.06s;
      }
      .dpad-btn.active {
        color: #4af;
      }
      .dpad-up {
        top: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 50px;
        height: 50px;
      }
      .dpad-up.active {
        transform: translateX(-50%) scale(0.9);
      }
      .dpad-down {
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 50px;
        height: 50px;
      }
      .dpad-down.active {
        transform: translateX(-50%) scale(0.9);
      }
      .dpad-left {
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 50px;
        height: 50px;
      }
      .dpad-left.active {
        transform: translateY(-50%) scale(0.9);
      }
      .dpad-right {
        right: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 50px;
        height: 50px;
      }
      .dpad-right.active {
        transform: translateY(-50%) scale(0.9);
      }
      .center-btns {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 6px;
        padding-top: 40px;
      }
      .meta-row {
        display: flex;
        gap: 14px;
      }
      .meta-btn {
        width: 62px;
        height: 24px;
        border-radius: 12px;
        border: none;
        background: linear-gradient(180deg, #333 0%, #222 100%);
        box-shadow:
          0 2px 4px rgba(0, 0, 0, 0.5),
          inset 0 1px 0 rgba(255, 255, 255, 0.05);
        cursor: pointer;
        transition: all 0.08s;
      }
      .meta-btn.active {
        background: linear-gradient(180deg, #444 0%, #333 100%);
        box-shadow:
          0 1px 2px rgba(0, 0, 0, 0.5),
          inset 0 1px 0 rgba(255, 255, 255, 0.08);
        transform: translateY(1px);
      }
      .meta-label {
        font-family: "Press Start 2P", monospace;
        font-size: clamp(5px, 1vw, 7px);
        color: #445;
        letter-spacing: 1px;
        text-align: center;
        margin-top: 4px;
      }
      .ab-wrap {
        position: relative;
        width: 170px;
        height: 170px;
        flex-shrink: 0;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .ab-tilt {
        transform: rotate(0deg);
      }
      .ab-row {
        display: flex;
        gap: 18px;
        align-items: center;
      }
      .face-btn {
        width: 66px;
        height: 66px;
        border-radius: 50%;
        border: none;
        cursor: pointer;
        position: relative;
        transition: all 0.08s;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: "Press Start 2P", monospace;
        font-size: clamp(11px, 2vw, 14px);
        color: rgba(255, 255, 255, 0.7);
        text-shadow: 0 -1px 1px rgba(0, 0, 0, 0.4);
      }
      .btn-a {
        background: linear-gradient(145deg, #c03040 0%, #901828 100%);
        box-shadow:
          0 4px 8px rgba(0, 0, 0, 0.6),
          0 0 0 3px #1a1a22,
          inset 0 1px 0 rgba(255, 255, 255, 0.15);
      }
      .btn-a.active {
        background: linear-gradient(145deg, #e04050 0%, #b02838 100%);
        box-shadow:
          0 2px 4px rgba(0, 0, 0, 0.6),
          0 0 0 3px #1a1a22,
          0 0 20px rgba(224, 64, 80, 0.3),
          inset 0 1px 0 rgba(255, 255, 255, 0.2);
        transform: scale(0.93);
      }
      .btn-b {
        background: linear-gradient(145deg, #c03040 0%, #901828 100%);
        box-shadow:
          0 4px 8px rgba(0, 0, 0, 0.6),
          0 0 0 3px #1a1a22,
          inset 0 1px 0 rgba(255, 255, 255, 0.15);
      }
      .btn-b.active {
        background: linear-gradient(145deg, #e04050 0%, #b02838 100%);
        box-shadow:
          0 2px 4px rgba(0, 0, 0, 0.6),
          0 0 0 3px #1a1a22,
          0 0 20px rgba(224, 64, 80, 0.3),
          inset 0 1px 0 rgba(255, 255, 255, 0.2);
        transform: scale(0.93);
      }
      .ab-label {
        font-family: "Press Start 2P", monospace;
        font-size: clamp(6px, 1vw, 8px);
        color: #445;
        text-align: center;
        margin-top: 4px;
      }
      .grooves {
        position: absolute;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        gap: 3px;
      }
      .groove {
        width: 40px;
        height: 3px;
        border-radius: 2px;
        background: #16161e;
      }
      @media (max-width: 600px) {
        body {
          align-items: flex-end;
        }
        .controller {
          width: 100vw;
          height: 100vh;
          height: 100dvh;
          border-radius: 0;
          padding: 12px;
          padding-top: max(12px, env(safe-area-inset-top));
          padding-bottom: max(20px, env(safe-area-inset-bottom));
          box-shadow:
            inset 0 1px 0 rgba(255, 255, 255, 0.04),
            inset 0 -2px 0 rgba(0, 0, 0, 0.3);
        }
        .screen-bar {
          margin: 0 4px 10px;
        }
        .controls {
          padding: 0 4px;
        }
        .dpad-wrap {
          width: 156px;
          height: 156px;
        }
        .dpad {
          width: 136px;
          height: 136px;
        }
        .dpad-h {
          height: 46px;
        }
        .dpad-v {
          width: 46px;
        }
        .dpad-btn {
          font-size: 17px;
        }
        .dpad-up,
        .dpad-down {
          width: 46px;
          height: 46px;
        }
        .dpad-left,
        .dpad-right {
          width: 46px;
          height: 46px;
        }
        .face-btn {
          width: 62px;
          height: 62px;
        }
        .ab-wrap {
          width: 156px;
          height: 156px;
        }
        .grooves {
          bottom: max(14px, env(safe-area-inset-bottom));
        }
        .groove {
          width: 28px;
        }
      }
      @media (max-width: 380px) {
        .dpad-wrap {
          width: 134px;
          height: 134px;
        }
        .dpad {
          width: 118px;
          height: 118px;
        }
        .dpad-h {
          height: 40px;
        }
        .dpad-v {
          width: 40px;
        }
        .dpad-up,
        .dpad-down {
          width: 40px;
          height: 40px;
        }
        .dpad-left,
        .dpad-right {
          width: 40px;
          height: 40px;
        }
        .dpad-btn {
          font-size: 15px;
        }
        .ab-wrap {
          width: 134px;
          height: 134px;
        }
        .face-btn {
          width: 54px;
          height: 54px;
        }
        .ab-row {
          gap: 14px;
        }
        .meta-btn {
          width: 52px;
          height: 20px;
        }
        .meta-row {
          gap: 10px;
        }
      }
      @media (max-width: 600px) and(min-height:700px) {
        .controls {
          align-items: flex-end;
          padding-bottom: 30px;
        }
        .center-btns {
          padding-top: 20px;
          align-self: flex-end;
          padding-bottom: 40px;
        }
      }
      @media (orientation: landscape) and(max-height:500px) {
        .controller {
          width: 100vw;
          height: 100vh;
          height: 100dvh;
          border-radius: 0;
          padding: 6px 16px;
          padding-left: max(16px, env(safe-area-inset-left));
          padding-right: max(16px, env(safe-area-inset-right));
        }
        .top-bar {
          padding: 0 8px 4px;
        }
        .screen-bar {
          margin: 0 8px 6px;
          padding: 4px 10px;
          min-height: 22px;
        }
        .center-btns {
          padding-top: 10px;
        }
        .grooves {
          bottom: 8px;
        }
        .groove {
          width: 24px;
        }
      }
      @media (min-width: 601px) {
        .dpad-wrap {
          width: 180px;
          height: 180px;
        }
        .dpad {
          width: 158px;
          height: 158px;
        }
        .dpad-h {
          height: 54px;
        }
        .dpad-v {
          width: 54px;
        }
        .dpad-up,
        .dpad-down {
          width: 54px;
          height: 54px;
        }
        .dpad-left,
        .dpad-right {
          width: 54px;
          height: 54px;
        }
        .dpad-btn {
          font-size: 22px;
        }
        .ab-wrap {
          width: 180px;
          height: 180px;
        }
        .face-btn {
          width: 72px;
          height: 72px;
        }
        .ab-row {
          gap: 20px;
        }
      }
    </style>
  </head>
  <body>
    <div class="controller" id="ctrl">
      <div class="top-bar"><div class="brand">EGYDEVTEAM</div></div>
      <div class="screen-bar">
        <span class="screen-label">EXAMPLE CONTROLLER</span>
        <button class="hid-btn" id="hid-btn">&#x1F3AE; CONNECT</button>
        <div class="status-wrap">
          <div class="status-dot" id="dot"></div>
          <span id="status">CONNECTING...</span>
        </div>
      </div>
      <div class="controls">
        <div class="dpad-wrap">
          <div class="dpad">
            <div class="dpad-bg dpad-h"></div>
            <div class="dpad-bg dpad-v"></div>
            <div class="dpad-center"></div>
            <button class="dpad-btn dpad-up" data-b="16">&#9650;</button>
            <button class="dpad-btn dpad-down" data-b="32">&#9660;</button>
            <button class="dpad-btn dpad-left" data-b="64">&#9664;</button>
            <button class="dpad-btn dpad-right" data-b="128">&#9654;</button>
          </div>
        </div>
        <div class="center-btns">
          <div class="meta-row">
            <div>
              <button class="meta-btn" data-b="4"></button>
              <div class="meta-label">SELECT</div>
            </div>
            <div>
              <button class="meta-btn" data-b="8"></button>
              <div class="meta-label">START</div>
            </div>
          </div>
          <div style="margin-top: 12px">
            <button
              class="meta-btn"
              data-b="255"
              style="
                width: 80px;
                background: linear-gradient(180deg, #422 0%, #311 100%);
              "
            ></button>
            <div class="meta-label">EXIT EMU</div>
          </div>
        </div>
        <div class="ab-wrap">
          <div class="ab-tilt">
            <div class="ab-row">
              <div>
                <button class="face-btn btn-b" data-b="2">B</button>
                <div class="ab-label">B</div>
              </div>
              <div>
                <button class="face-btn btn-a" data-b="1">A</button>
                <div class="ab-label">A</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="grooves">
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
        <div class="groove"></div>
      </div>
    </div>
    <script>
      (function () {
        var S = document.getElementById("status"),
          DOT = document.getElementById("dot"),
          HIDBTN = document.getElementById("hid-btn");
        var state = 0,
          connected = false,
          gpIdx = null;
        function doSend() {
          try {
            fetch("/b" + state, { method: "POST", keepalive: true });
          } catch (e) {}
          if (!connected) {
            connected = true;
            DOT.classList.add("on");
            S.textContent = "CONNECTED";
          }
        }
        function send() {
          doSend();
        }
        function press(mask) {
          if (mask >= 254) {
            state = mask;
            send();
            state = 0;
            return;
          }
          if (!(state & mask)) {
            state |= mask;
            send();
          }
        }
        function release(mask) {
          if (mask >= 254) return;
          if (state & mask) {
            state &= ~mask;
            send();
          }
        }
        function btnOn(m) {
          document
            .querySelectorAll('[data-b="' + m + '"]')
            .forEach(function (e) {
              e.classList.add("active");
            });
        }
        function btnOff(m) {
          document
            .querySelectorAll('[data-b="' + m + '"]')
            .forEach(function (e) {
              e.classList.remove("active");
            });
        }
        function applyMask(m) {
          [1, 2, 4, 8, 16, 32, 64, 128].forEach(function (b) {
            if (m & b) btnOn(b);
            else btnOff(b);
          });
          state = m;
          send();
        }
        var touchMap = new Map();
        function processTouch(e) {
          e.preventDefault();
          var liveIds = new Set();
          for (var i = 0; i < e.touches.length; i++) {
            var t = e.touches[i];
            liveIds.add(t.identifier);
            var el = document.elementFromPoint(t.clientX, t.clientY);
            var m = el && el.dataset.b ? +el.dataset.b : null;
            var prev = touchMap.get(t.identifier);
            if (prev !== undefined && prev !== m) {
              touchMap.delete(t.identifier);
              release(prev);
              btnOff(prev);
            }
            if (m !== null && touchMap.get(t.identifier) !== m) {
              touchMap.set(t.identifier, m);
              press(m);
              btnOn(m);
            }
          }
          for (var p of touchMap) {
            if (!liveIds.has(p[0])) {
              touchMap.delete(p[0]);
              release(p[1]);
              btnOff(p[1]);
            }
          }
        }
        function processEnd(e) {
          e.preventDefault();
          var liveIds = new Set();
          for (var i = 0; i < e.touches.length; i++)
            liveIds.add(e.touches[i].identifier);
          for (var p of touchMap) {
            if (!liveIds.has(p[0])) {
              touchMap.delete(p[0]);
              release(p[1]);
              btnOff(p[1]);
            }
          }
        }
        document.addEventListener("touchstart", processTouch, {
          passive: false,
        });
        document.addEventListener("touchmove", processTouch, {
          passive: false,
        });
        document.addEventListener("touchend", processEnd, { passive: false });
        document.addEventListener("touchcancel", processEnd, {
          passive: false,
        });
        var mouseBtn = null;
        document.querySelectorAll("[data-b]").forEach(function (el) {
          el.addEventListener("mousedown", function (e) {
            e.preventDefault();
            var m = +el.dataset.b;
            mouseBtn = m;
            press(m);
            btnOn(m);
          });
        });
        window.addEventListener("mouseup", function () {
          if (mouseBtn !== null) {
            var m = mouseBtn;
            mouseBtn = null;
            release(m);
            btnOff(m);
          }
        });
        var KM = {
          ArrowUp: 16,
          w: 16,
          W: 16,
          ArrowDown: 32,
          s: 32,
          S: 32,
          ArrowLeft: 64,
          a: 64,
          A: 64,
          ArrowRight: 128,
          d: 128,
          D: 128,
          x: 1,
          X: 1,
          ".": 1,
          z: 2,
          Z: 2,
          ",": 2,
          Shift: 4,
          Enter: 8,
          " ": 8,
          Escape: 254,
          Tab: 255,
        };
        var kDown = new Set();
        window.addEventListener("keydown", function (e) {
          var m = KM[e.key];
          if (m !== undefined && !kDown.has(e.key)) {
            kDown.add(e.key);
            if (m >= 254) {
              state = m;
              send();
              state = 0;
            } else {
              press(m);
              btnOn(m);
            }
            e.preventDefault();
          }
        });
        window.addEventListener("keyup", function (e) {
          var m = KM[e.key];
          if (m !== undefined) {
            kDown.delete(e.key);
            if (m < 254) {
              release(m);
              btnOff(m);
            }
            e.preventDefault();
          }
        });
        var gpActive = false,
          hidConnected = false;
        window.addEventListener("gamepadconnected", function (e) {
          gpIdx = e.gamepad.index;
          S.textContent = e.gamepad.id.substring(0, 22);
          S.style.color = "#8af";
          gpActive = true;
          HIDBTN.classList.remove("show");
        });
        window.addEventListener("gamepaddisconnected", function () {
          gpIdx = null;
          gpActive = false;
          S.textContent = connected ? "CONNECTED" : "CONNECTING...";
          S.style.color = "";
          if (!hidConnected) showHidButton();
        });
        var prevGP = 0,
          gpFrames = 0;
        function pollGP() {
          try {
            var gps = navigator.getGamepads();
            if (gpIdx === null && gps) {
              for (var i = 0; i < gps.length; i++) {
                if (!gps[i] || !gps[i].connected) continue;
                for (var b = 0; b < gps[i].buttons.length; b++) {
                  if (gps[i].buttons[b].pressed) {
                    gpIdx = i;
                    gpActive = true;
                    S.textContent = gps[i].id.substring(0, 22);
                    S.style.color = "#8af";
                    HIDBTN.classList.remove("show");
                    break;
                  }
                }
                if (gpIdx !== null) break;
              }
            }
            if (gpIdx !== null && gps[gpIdx] && gps[gpIdx].connected) {
              var gp = gps[gpIdx];
              var m = 0;
              var nb = gp.buttons.length;
              if (nb > 0 && gp.buttons[0].pressed) m |= 1;
              if (nb > 2 && gp.buttons[2].pressed) m |= 2;
              if (nb > 1 && gp.buttons[1].pressed) m |= 2;
              if (nb > 8 && gp.buttons[8].pressed) m |= 4;
              if (nb > 6 && gp.buttons[6].pressed) m |= 4;
              if (nb > 9 && gp.buttons[9].pressed) m |= 8;
              if (nb > 7 && gp.buttons[7].pressed) m |= 8;
              if (nb > 12 && gp.buttons[12].pressed) m |= 16;
              if (nb > 13 && gp.buttons[13].pressed) m |= 32;
              if (nb > 14 && gp.buttons[14].pressed) m |= 64;
              if (nb > 15 && gp.buttons[15].pressed) m |= 128;
              if (gp.axes.length >= 2) {
                if (gp.axes[1] < -0.5) m |= 16;
                if (gp.axes[1] > 0.5) m |= 32;
                if (gp.axes[0] < -0.5) m |= 64;
                if (gp.axes[0] > 0.5) m |= 128;
              }
              if (gp.axes.length >= 4) {
                if (gp.axes[3] < -0.5 || gp.axes[3] > 3) m |= 16;
                if (gp.axes[3] > 0.5 && gp.axes[3] < 2) m |= 32;
                if (gp.axes[2] < -0.5) m |= 64;
                if (gp.axes[2] > 0.5) m |= 128;
              }
              if (gp.axes.length >= 8) {
                if (gp.axes[7] < -0.5) m |= 16;
                if (gp.axes[7] > 0.5) m |= 32;
                if (gp.axes[6] < -0.5) m |= 64;
                if (gp.axes[6] > 0.5) m |= 128;
              }
              if (nb > 4 && gp.buttons[4].pressed) {
                state = 254;
                send();
                state = 0;
                prevGP = m;
                requestAnimationFrame(pollGP);
                return;
              }
              if (nb > 5 && gp.buttons[5].pressed) {
                state = 255;
                send();
                state = 0;
                prevGP = m;
                requestAnimationFrame(pollGP);
                return;
              }
              gpFrames++;
              if (m !== prevGP || (m !== 0 && gpFrames % 5 === 0)) {
                applyMask(m);
                prevGP = m;
              }
            } else if (
              gpIdx !== null &&
              (!gps[gpIdx] || !gps[gpIdx].connected)
            ) {
              gpIdx = null;
              gpActive = false;
            }
          } catch (e) {}
          requestAnimationFrame(pollGP);
        }
        requestAnimationFrame(pollGP);
        var DS_VID = 0x054c,
          DS_PID = 0x0ce6,
          DS_EDGE = 0x0df2;
        var hidDevice = null,
          hidMode = null,
          hidPrevMask = -1;
        var HAT = [16, 16 | 128, 128, 32 | 128, 32, 32 | 64, 64, 16 | 64, 0];
        function parseDualSense(rid, data) {
          var m = 0,
            db,
            b0,
            b1,
            lx,
            ly;
          if (rid === 0x01 && data.byteLength >= 9 && data.byteLength <= 10) {
            lx = data.getUint8(0);
            ly = data.getUint8(1);
            db = data.getUint8(4);
            b0 = db;
            b1 = data.getUint8(5);
            var h = db & 0x0f;
            m |= HAT[h > 8 ? 8 : h];
            if (b0 & 0x20) m |= 1;
            if (b0 & 0x40) m |= 2;
            if (b0 & 0x10) m |= 2;
            if (b1 & 0x10) m |= 4;
            if (b1 & 0x20) m |= 8;
            if (b1 & 0x01) {
              state = 254;
              send();
              state = 0;
              return;
            }
            if (b1 & 0x02) {
              state = 255;
              send();
              state = 0;
              return;
            }
            if (lx < 64) m |= 64;
            if (lx > 192) m |= 128;
            if (ly < 64) m |= 16;
            if (ly > 192) m |= 32;
            hidMode = "bt-simple";
          } else if (rid === 0x01 && data.byteLength >= 63) {
            lx = data.getUint8(0);
            ly = data.getUint8(1);
            db = data.getUint8(7);
            b1 = data.getUint8(8);
            var h = db & 0x0f;
            m |= HAT[h > 8 ? 8 : h];
            if (db & 0x20) m |= 1;
            if (db & 0x40) m |= 2;
            if (db & 0x10) m |= 2;
            if (b1 & 0x10) m |= 4;
            if (b1 & 0x20) m |= 8;
            if (b1 & 0x01) {
              state = 254;
              send();
              state = 0;
              return;
            }
            if (b1 & 0x02) {
              state = 255;
              send();
              state = 0;
              return;
            }
            if (lx < 64) m |= 64;
            if (lx > 192) m |= 128;
            if (ly < 64) m |= 16;
            if (ly > 192) m |= 32;
            hidMode = "usb";
          } else if (rid === 0x31 && data.byteLength >= 77) {
            var o = 1;
            lx = data.getUint8(o);
            ly = data.getUint8(o + 1);
            db = data.getUint8(o + 7);
            b1 = data.getUint8(o + 8);
            var h = db & 0x0f;
            m |= HAT[h > 8 ? 8 : h];
            if (db & 0x20) m |= 1;
            if (db & 0x40) m |= 2;
            if (db & 0x10) m |= 2;
            if (b1 & 0x10) m |= 4;
            if (b1 & 0x20) m |= 8;
            if (b1 & 0x01) {
              state = 254;
              send();
              state = 0;
              return;
            }
            if (b1 & 0x02) {
              state = 255;
              send();
              state = 0;
              return;
            }
            if (lx < 64) m |= 64;
            if (lx > 192) m |= 128;
            if (ly < 64) m |= 16;
            if (ly > 192) m |= 32;
            hidMode = "bt-ext";
          } else return;
          if (m !== hidPrevMask) {
            applyMask(m);
            hidPrevMask = m;
          }
        }
        async function tryExt(dev) {
          try {
            await dev.receiveFeatureReport(0x05);
          } catch (e) {}
        }
        async function connectHID() {
          if (!navigator.hid) {
            S.textContent = "WebHID N/A";
            S.style.color = "#f44";
            return;
          }
          try {
            var devs = await navigator.hid.requestDevice({
              filters: [
                { vendorId: DS_VID, productId: DS_PID },
                { vendorId: DS_VID, productId: DS_EDGE },
              ],
            });
            if (!devs || devs.length === 0) {
              S.textContent = "NO DEVICE";
              S.style.color = "#f44";
              return;
            }
            hidDevice = devs[0];
            if (!hidDevice.opened) await hidDevice.open();
            hidConnected = true;
            DOT.classList.add("on");
            connected = true;
            HIDBTN.classList.remove("show");
            var nm = hidDevice.productName || "DualSense";
            S.textContent = "\u{1F3AE} " + nm.substring(0, 18);
            S.style.color = "#4f8";
            hidDevice.addEventListener("inputreport", function (e) {
              parseDualSense(e.reportId, e.data);
            });
            await tryExt(hidDevice);
          } catch (e) {
            if (e.name !== "NotAllowedError") {
              S.textContent = "HID ERROR";
              S.style.color = "#f44";
            }
          }
        }
        function showHidButton() {
          if (navigator.hid && !hidConnected && gpIdx === null)
            HIDBTN.classList.add("show");
        }
        HIDBTN.addEventListener("click", function (e) {
          e.preventDefault();
          e.stopPropagation();
          connectHID();
        });
        async function autoReconnect() {
          if (!navigator.hid) return;
          try {
            var devs = await navigator.hid.getDevices();
            for (var i = 0; i < devs.length; i++) {
              var d = devs[i];
              if (
                d.vendorId === DS_VID &&
                (d.productId === DS_PID || d.productId === DS_EDGE)
              ) {
                hidDevice = d;
                if (!hidDevice.opened) await hidDevice.open();
                hidConnected = true;
                DOT.classList.add("on");
                connected = true;
                HIDBTN.classList.remove("show");
                var nm = hidDevice.productName || "DualSense";
                S.textContent = "\u{1F3AE} " + nm.substring(0, 18);
                S.style.color = "#4f8";
                hidDevice.addEventListener("inputreport", function (e) {
                  parseDualSense(e.reportId, e.data);
                });
                await tryExt(hidDevice);
                return;
              }
            }
          } catch (e) {}
          setTimeout(showHidButton, 2000);
        }
        autoReconnect();
      })();
    </script>
  </body>
</html>
]=]

local html_resp = "HTTP/1.1 200 OK\r\nContent-Type:text/html\r\nConnection:close\r\n\r\n" .. html_body
local html_len = #html_resp
local html_mem = malloc(html_len + 16)
write_buffer(html_mem, html_resp)
ulog("HTML: " .. html_len .. " bytes")

local ftp_srv = create_socket(AF_INET, 1, 0)
if ftp_srv >= 0 then
    local en = malloc(4); write32(en, 1)
    syscall.setsockopt(ftp_srv, 0xFFFF, 0x0004, en, 4)
    syscall.setsockopt(ftp_srv, 0xFFFF, 0x0200, en, 4)
    local ba = make_sockaddr_in(1337)
    local ret = syscall.bind(ftp_srv, ba, 16)
    ulog("ftp_srv fd=" .. tostring(ftp_srv) .. " bind=" .. tostring(ret))
    syscall.listen(ftp_srv, 128)
end

local ftp_data = create_socket(AF_INET, 1, 0)
if ftp_data >= 0 then
    local en = malloc(4); write32(en, 1)
    syscall.setsockopt(ftp_data, 0xFFFF, 0x0004, en, 4)
    syscall.setsockopt(ftp_data, 0xFFFF, 0x0200, en, 4)
    local ba = make_sockaddr_in(1338)
    local ret = syscall.bind(ftp_data, ba, 16)
    ulog("ftp_data fd=" .. tostring(ftp_data) .. " bind=" .. tostring(ret))
    syscall.listen(ftp_data, 128)
end

sc = sc:gsub("%s", "")
local bin = hex_to_binary(sc)
local JIT_SIZE = 0x10000
local bfd = jit_malloc(8)
local rwfd = jit_malloc(8)
local rxfd = jit_malloc(8)
local rwa = jit_malloc(8)
local rxa = malloc(8)
local nm = jit_malloc(8)
jit_write_buffer(nm, "nv4b")
jit_sceKernelJitCreateSharedMemory(nm, JIT_SIZE, 7, bfd)
jit_sceKernelJitCreateAliasOfSharedMemory(jit_read32(bfd), PROT_READ|PROT_WRITE, rwfd)
jit_sceKernelJitCreateAliasOfSharedMemory(jit_read32(bfd), PROT_READ|PROT_EXECUTE, rxfd)
jit_sceKernelJitMapSharedMemory(jit_read32(rwfd), PROT_READ|PROT_WRITE, rwa)
local rw = jit_read64(rwa)
local mfd = jit_send_recv_fd(jit_read32(rxfd), NEW_JIT_SOCK, NEW_MAIN_SOCK)
sceKernelJitMapSharedMemory(mfd, PROT_READ|PROT_EXECUTE, rxa)
local rx = read64(rxa)
write_shellcode(rw, sc)
ulog("Code: " .. #bin .. " bytes")

local ext = malloc(0x80)
memset(ext, 0, 0x80)
write64(ext+0x00, 0xDEAD)
write32(ext+0x18, log_sock)
write32(ext+0x1C, -1)
for i=0,15 do write8(ext+0x20+i, read8(log_sa+i)) end
write64(ext+0x30, web_sock >= 0 and web_sock or -1)
write64(ext+0x38, html_mem)
write64(ext+0x40, html_len)
write64(ext+0x48, userId)
write64(ext+0x50, ftp_srv >= 0 and ftp_srv or -1)
write64(ext+0x58, ftp_data >= 0 and ftp_data or -1)
local current_ip = get_current_ip()
ulog("IP: " .. current_ip)
send_notification("Example V1.0\nhttp://" .. current_ip .. ":" .. WEB_PORT)

func_wrap(rx)(EBOOT_BASE, SCE_KERNEL_DLSYM, ext)

local frames = read32(ext+0x10)
ulog("Done! frames=" .. frames)
send_notification("Example done " .. frames .. "f")
