package com.wakuworks.idna 
{
	/**
	 * Unicode文字列の正規化を行います。
	 * 
	 * @author  Kazunori Ninomiya
	 * @version 0.1.0
	 * @version Project 0.1.0
	 * @since   0.1.0
	 * @license http://www.opensource.org/licenses/mit-license.php The MIT License
	 * @see     <a href="http://www.jdna.jp/survey/rfc/rfc3454j.html">RFC3454</a>
	 */
	final public class Nameprep
	{
		// 変換表
		private static var _mappingTable:String = <![CDATA[
			0041; 0061; Case map
			0042; 0062; Case map
			0043; 0063; Case map
			0044; 0064; Case map
			0045; 0065; Case map
			0046; 0066; Case map
			0047; 0067; Case map
			0048; 0068; Case map
			0049; 0069; Case map
			004A; 006A; Case map
			004B; 006B; Case map
			004C; 006C; Case map
			004D; 006D; Case map
			004E; 006E; Case map
			004F; 006F; Case map
			0050; 0070; Case map
			0051; 0071; Case map
			0052; 0072; Case map
			0053; 0073; Case map
			0054; 0074; Case map
			0055; 0075; Case map
			0056; 0076; Case map
			0057; 0077; Case map
			0058; 0078; Case map
			0059; 0079; Case map
			005A; 007A; Case map
			00AD; ; Map out
			00B5; 03BC; Case map
			00C0; 00E0; Case map
			00C1; 00E1; Case map
			00C2; 00E2; Case map
			00C3; 00E3; Case map
			00C4; 00E4; Case map
			00C5; 00E5; Case map
			00C6; 00E6; Case map
			00C7; 00E7; Case map
			00C8; 00E8; Case map
			00C9; 00E9; Case map
			00CA; 00EA; Case map
			00CB; 00EB; Case map
			00CC; 00EC; Case map
			00CD; 00ED; Case map
			00CE; 00EE; Case map
			00CF; 00EF; Case map
			00D0; 00F0; Case map
			00D1; 00F1; Case map
			00D2; 00F2; Case map
			00D3; 00F3; Case map
			00D4; 00F4; Case map
			00D5; 00F5; Case map
			00D6; 00F6; Case map
			00D8; 00F8; Case map
			00D9; 00F9; Case map
			00DA; 00FA; Case map
			00DB; 00FB; Case map
			00DC; 00FC; Case map
			00DD; 00FD; Case map
			00DE; 00FE; Case map
			00DF; 0073 0073; Case map
			0100; 0101; Case map
			0102; 0103; Case map
			0104; 0105; Case map
			0106; 0107; Case map
			0108; 0109; Case map
			010A; 010B; Case map
			010C; 010D; Case map
			010E; 010F; Case map
			0110; 0111; Case map
			0112; 0113; Case map
			0114; 0115; Case map
			0116; 0117; Case map
			0118; 0119; Case map
			011A; 011B; Case map
			011C; 011D; Case map
			011E; 011F; Case map
			0120; 0121; Case map
			0122; 0123; Case map
			0124; 0125; Case map
			0126; 0127; Case map
			0128; 0129; Case map
			012A; 012B; Case map
			012C; 012D; Case map
			012E; 012F; Case map
			0130; 0069; Case map
			0131; 0069; Case map
			0132; 0133; Case map
			0134; 0135; Case map
			0136; 0137; Case map
			0139; 013A; Case map
			013B; 013C; Case map
			013D; 013E; Case map
			013F; 0140; Case map
			0141; 0142; Case map
			0143; 0144; Case map
			0145; 0146; Case map
			0147; 0148; Case map
			0149; 02BC 006E; Case map
			014A; 014B; Case map
			014C; 014D; Case map
			014E; 014F; Case map
			0150; 0151; Case map
			0152; 0153; Case map
			0154; 0155; Case map
			0156; 0157; Case map
			0158; 0159; Case map
			015A; 015B; Case map
			015C; 015D; Case map
			015E; 015F; Case map
			0160; 0161; Case map
			0162; 0163; Case map
			0164; 0165; Case map
			0166; 0167; Case map
			0168; 0169; Case map
			016A; 016B; Case map
			016C; 016D; Case map
			016E; 016F; Case map
			0170; 0171; Case map
			0172; 0173; Case map
			0174; 0175; Case map
			0176; 0177; Case map
			0178; 00FF; Case map
			0179; 017A; Case map
			017B; 017C; Case map
			017D; 017E; Case map
			017F; 0073; Case map
			0181; 0253; Case map
			0182; 0183; Case map
			0184; 0185; Case map
			0186; 0254; Case map
			0187; 0188; Case map
			0189; 0256; Case map
			018A; 0257; Case map
			018B; 018C; Case map
			018E; 01DD; Case map
			018F; 0259; Case map
			0190; 025B; Case map
			0191; 0192; Case map
			0193; 0260; Case map
			0194; 0263; Case map
			0196; 0269; Case map
			0197; 0268; Case map
			0198; 0199; Case map
			019C; 026F; Case map
			019D; 0272; Case map
			019F; 0275; Case map
			01A0; 01A1; Case map
			01A2; 01A3; Case map
			01A4; 01A5; Case map
			01A6; 0280; Case map
			01A7; 01A8; Case map
			01A9; 0283; Case map
			01AC; 01AD; Case map
			01AE; 0288; Case map
			01AF; 01B0; Case map
			01B1; 028A; Case map
			01B2; 028B; Case map
			01B3; 01B4; Case map
			01B5; 01B6; Case map
			01B7; 0292; Case map
			01B8; 01B9; Case map
			01BC; 01BD; Case map
			01C4; 01C6; Case map
			01C5; 01C6; Case map
			01C7; 01C9; Case map
			01C8; 01C9; Case map
			01CA; 01CC; Case map
			01CB; 01CC; Case map
			01CD; 01CE; Case map
			01CF; 01D0; Case map
			01D1; 01D2; Case map
			01D3; 01D4; Case map
			01D5; 01D6; Case map
			01D7; 01D8; Case map
			01D9; 01DA; Case map
			01DB; 01DC; Case map
			01DE; 01DF; Case map
			01E0; 01E1; Case map
			01E2; 01E3; Case map
			01E4; 01E5; Case map
			01E6; 01E7; Case map
			01E8; 01E9; Case map
			01EA; 01EB; Case map
			01EC; 01ED; Case map
			01EE; 01EF; Case map
			01F0; 006A 030C; Case map
			01F1; 01F3; Case map
			01F2; 01F3; Case map
			01F4; 01F5; Case map
			01F6; 0195; Case map
			01F7; 01BF; Case map
			01F8; 01F9; Case map
			01FA; 01FB; Case map
			01FC; 01FD; Case map
			01FE; 01FF; Case map
			0200; 0201; Case map
			0202; 0203; Case map
			0204; 0205; Case map
			0206; 0207; Case map
			0208; 0209; Case map
			020A; 020B; Case map
			020C; 020D; Case map
			020E; 020F; Case map
			0210; 0211; Case map
			0212; 0213; Case map
			0214; 0215; Case map
			0216; 0217; Case map
			0218; 0219; Case map
			021A; 021B; Case map
			021C; 021D; Case map
			021E; 021F; Case map
			0222; 0223; Case map
			0224; 0225; Case map
			0226; 0227; Case map
			0228; 0229; Case map
			022A; 022B; Case map
			022C; 022D; Case map
			022E; 022F; Case map
			0230; 0231; Case map
			0232; 0233; Case map
			0345; 03B9; Case map
			037A; 0020 03B9; Additional folding
			0386; 03AC; Case map
			0388; 03AD; Case map
			0389; 03AE; Case map
			038A; 03AF; Case map
			038C; 03CC; Case map
			038E; 03CD; Case map
			038F; 03CE; Case map
			0390; 03B9 0308 0301; Case map
			0391; 03B1; Case map
			0392; 03B2; Case map
			0393; 03B3; Case map
			0394; 03B4; Case map
			0395; 03B5; Case map
			0396; 03B6; Case map
			0397; 03B7; Case map
			0398; 03B8; Case map
			0399; 03B9; Case map
			039A; 03BA; Case map
			039B; 03BB; Case map
			039C; 03BC; Case map
			039D; 03BD; Case map
			039E; 03BE; Case map
			039F; 03BF; Case map
			03A0; 03C0; Case map
			03A1; 03C1; Case map
			03A3; 03C2; Case map
			03A4; 03C4; Case map
			03A5; 03C5; Case map
			03A6; 03C6; Case map
			03A7; 03C7; Case map
			03A8; 03C8; Case map
			03A9; 03C9; Case map
			03AA; 03CA; Case map
			03AB; 03CB; Case map
			03B0; 03C5 0308 0301; Case map
			03C2; 03C2; Case map
			03C3; 03C2; Case map
			03D0; 03B2; Case map
			03D1; 03B8; Case map
			03D2; 03C5; Additional folding
			03D3; 03CD; Additional folding
			03D4; 03CB; Additional folding
			03D5; 03C6; Case map
			03D6; 03C0; Case map
			03DA; 03DB; Case map
			03DC; 03DD; Case map
			03DE; 03DF; Case map
			03E0; 03E1; Case map
			03E2; 03E3; Case map
			03E4; 03E5; Case map
			03E6; 03E7; Case map
			03E8; 03E9; Case map
			03EA; 03EB; Case map
			03EC; 03ED; Case map
			03EE; 03EF; Case map
			03F0; 03BA; Case map
			03F1; 03C1; Case map
			03F2; 03C2; Case map
			0400; 0450; Case map
			0401; 0451; Case map
			0402; 0452; Case map
			0403; 0453; Case map
			0404; 0454; Case map
			0405; 0455; Case map
			0406; 0456; Case map
			0407; 0457; Case map
			0408; 0458; Case map
			0409; 0459; Case map
			040A; 045A; Case map
			040B; 045B; Case map
			040C; 045C; Case map
			040D; 045D; Case map
			040E; 045E; Case map
			040F; 045F; Case map
			0410; 0430; Case map
			0411; 0431; Case map
			0412; 0432; Case map
			0413; 0433; Case map
			0414; 0434; Case map
			0415; 0435; Case map
			0416; 0436; Case map
			0417; 0437; Case map
			0418; 0438; Case map
			0419; 0439; Case map
			041A; 043A; Case map
			041B; 043B; Case map
			041C; 043C; Case map
			041D; 043D; Case map
			041E; 043E; Case map
			041F; 043F; Case map
			0420; 0440; Case map
			0421; 0441; Case map
			0422; 0442; Case map
			0423; 0443; Case map
			0424; 0444; Case map
			0425; 0445; Case map
			0426; 0446; Case map
			0427; 0447; Case map
			0428; 0448; Case map
			0429; 0449; Case map
			042A; 044A; Case map
			042B; 044B; Case map
			042C; 044C; Case map
			042D; 044D; Case map
			042E; 044E; Case map
			042F; 044F; Case map
			0460; 0461; Case map
			0462; 0463; Case map
			0464; 0465; Case map
			0466; 0467; Case map
			0468; 0469; Case map
			046A; 046B; Case map
			046C; 046D; Case map
			046E; 046F; Case map
			0470; 0471; Case map
			0472; 0473; Case map
			0474; 0475; Case map
			0476; 0477; Case map
			0478; 0479; Case map
			047A; 047B; Case map
			047C; 047D; Case map
			047E; 047F; Case map
			0480; 0481; Case map
			048C; 048D; Case map
			048E; 048F; Case map
			0490; 0491; Case map
			0492; 0493; Case map
			0494; 0495; Case map
			0496; 0497; Case map
			0498; 0499; Case map
			049A; 049B; Case map
			049C; 049D; Case map
			049E; 049F; Case map
			04A0; 04A1; Case map
			04A2; 04A3; Case map
			04A4; 04A5; Case map
			04A6; 04A7; Case map
			04A8; 04A9; Case map
			04AA; 04AB; Case map
			04AC; 04AD; Case map
			04AE; 04AF; Case map
			04B0; 04B1; Case map
			04B2; 04B3; Case map
			04B4; 04B5; Case map
			04B6; 04B7; Case map
			04B8; 04B9; Case map
			04BA; 04BB; Case map
			04BC; 04BD; Case map
			04BE; 04BF; Case map
			04C1; 04C2; Case map
			04C3; 04C4; Case map
			04C7; 04C8; Case map
			04CB; 04CC; Case map
			04D0; 04D1; Case map
			04D2; 04D3; Case map
			04D4; 04D5; Case map
			04D6; 04D7; Case map
			04D8; 04D9; Case map
			04DA; 04DB; Case map
			04DC; 04DD; Case map
			04DE; 04DF; Case map
			04E0; 04E1; Case map
			04E2; 04E3; Case map
			04E4; 04E5; Case map
			04E6; 04E7; Case map
			04E8; 04E9; Case map
			04EA; 04EB; Case map
			04EC; 04ED; Case map
			04EE; 04EF; Case map
			04F0; 04F1; Case map
			04F2; 04F3; Case map
			04F4; 04F5; Case map
			04F8; 04F9; Case map
			0531; 0561; Case map
			0532; 0562; Case map
			0533; 0563; Case map
			0534; 0564; Case map
			0535; 0565; Case map
			0536; 0566; Case map
			0537; 0567; Case map
			0538; 0568; Case map
			0539; 0569; Case map
			053A; 056A; Case map
			053B; 056B; Case map
			053C; 056C; Case map
			053D; 056D; Case map
			053E; 056E; Case map
			053F; 056F; Case map
			0540; 0570; Case map
			0541; 0571; Case map
			0542; 0572; Case map
			0543; 0573; Case map
			0544; 0574; Case map
			0545; 0575; Case map
			0546; 0576; Case map
			0547; 0577; Case map
			0548; 0578; Case map
			0549; 0579; Case map
			054A; 057A; Case map
			054B; 057B; Case map
			054C; 057C; Case map
			054D; 057D; Case map
			054E; 057E; Case map
			054F; 057F; Case map
			0550; 0580; Case map
			0551; 0581; Case map
			0552; 0582; Case map
			0553; 0583; Case map
			0554; 0584; Case map
			0555; 0585; Case map
			0556; 0586; Case map
			0587; 0565 0582; Case map
			1806; ; Map out
			180B; ; Map out
			180C; ; Map out
			180D; ; Map out
			1E00; 1E01; Case map
			1E02; 1E03; Case map
			1E04; 1E05; Case map
			1E06; 1E07; Case map
			1E08; 1E09; Case map
			1E0A; 1E0B; Case map
			1E0C; 1E0D; Case map
			1E0E; 1E0F; Case map
			1E10; 1E11; Case map
			1E12; 1E13; Case map
			1E14; 1E15; Case map
			1E16; 1E17; Case map
			1E18; 1E19; Case map
			1E1A; 1E1B; Case map
			1E1C; 1E1D; Case map
			1E1E; 1E1F; Case map
			1E20; 1E21; Case map
			1E22; 1E23; Case map
			1E24; 1E25; Case map
			1E26; 1E27; Case map
			1E28; 1E29; Case map
			1E2A; 1E2B; Case map
			1E2C; 1E2D; Case map
			1E2E; 1E2F; Case map
			1E30; 1E31; Case map
			1E32; 1E33; Case map
			1E34; 1E35; Case map
			1E36; 1E37; Case map
			1E38; 1E39; Case map
			1E3A; 1E3B; Case map
			1E3C; 1E3D; Case map
			1E3E; 1E3F; Case map
			1E40; 1E41; Case map
			1E42; 1E43; Case map
			1E44; 1E45; Case map
			1E46; 1E47; Case map
			1E48; 1E49; Case map
			1E4A; 1E4B; Case map
			1E4C; 1E4D; Case map
			1E4E; 1E4F; Case map
			1E50; 1E51; Case map
			1E52; 1E53; Case map
			1E54; 1E55; Case map
			1E56; 1E57; Case map
			1E58; 1E59; Case map
			1E5A; 1E5B; Case map
			1E5C; 1E5D; Case map
			1E5E; 1E5F; Case map
			1E60; 1E61; Case map
			1E62; 1E63; Case map
			1E64; 1E65; Case map
			1E66; 1E67; Case map
			1E68; 1E69; Case map
			1E6A; 1E6B; Case map
			1E6C; 1E6D; Case map
			1E6E; 1E6F; Case map
			1E70; 1E71; Case map
			1E72; 1E73; Case map
			1E74; 1E75; Case map
			1E76; 1E77; Case map
			1E78; 1E79; Case map
			1E7A; 1E7B; Case map
			1E7C; 1E7D; Case map
			1E7E; 1E7F; Case map
			1E80; 1E81; Case map
			1E82; 1E83; Case map
			1E84; 1E85; Case map
			1E86; 1E87; Case map
			1E88; 1E89; Case map
			1E8A; 1E8B; Case map
			1E8C; 1E8D; Case map
			1E8E; 1E8F; Case map
			1E90; 1E91; Case map
			1E92; 1E93; Case map
			1E94; 1E95; Case map
			1E96; 0068 0331; Case map
			1E97; 0074 0308; Case map
			1E98; 0077 030A; Case map
			1E99; 0079 030A; Case map
			1E9A; 0061 02BE; Case map
			1E9B; 1E61; Case map
			1EA0; 1EA1; Case map
			1EA2; 1EA3; Case map
			1EA4; 1EA5; Case map
			1EA6; 1EA7; Case map
			1EA8; 1EA9; Case map
			1EAA; 1EAB; Case map
			1EAC; 1EAD; Case map
			1EAE; 1EAF; Case map
			1EB0; 1EB1; Case map
			1EB2; 1EB3; Case map
			1EB4; 1EB5; Case map
			1EB6; 1EB7; Case map
			1EB8; 1EB9; Case map
			1EBA; 1EBB; Case map
			1EBC; 1EBD; Case map
			1EBE; 1EBF; Case map
			1EC0; 1EC1; Case map
			1EC2; 1EC3; Case map
			1EC4; 1EC5; Case map
			1EC6; 1EC7; Case map
			1EC8; 1EC9; Case map
			1ECA; 1ECB; Case map
			1ECC; 1ECD; Case map
			1ECE; 1ECF; Case map
			1ED0; 1ED1; Case map
			1ED2; 1ED3; Case map
			1ED4; 1ED5; Case map
			1ED6; 1ED7; Case map
			1ED8; 1ED9; Case map
			1EDA; 1EDB; Case map
			1EDC; 1EDD; Case map
			1EDE; 1EDF; Case map
			1EE0; 1EE1; Case map
			1EE2; 1EE3; Case map
			1EE4; 1EE5; Case map
			1EE6; 1EE7; Case map
			1EE8; 1EE9; Case map
			1EEA; 1EEB; Case map
			1EEC; 1EED; Case map
			1EEE; 1EEF; Case map
			1EF0; 1EF1; Case map
			1EF2; 1EF3; Case map
			1EF4; 1EF5; Case map
			1EF6; 1EF7; Case map
			1EF8; 1EF9; Case map
			1F08; 1F00; Case map
			1F09; 1F01; Case map
			1F0A; 1F02; Case map
			1F0B; 1F03; Case map
			1F0C; 1F04; Case map
			1F0D; 1F05; Case map
			1F0E; 1F06; Case map
			1F0F; 1F07; Case map
			1F18; 1F10; Case map
			1F19; 1F11; Case map
			1F1A; 1F12; Case map
			1F1B; 1F13; Case map
			1F1C; 1F14; Case map
			1F1D; 1F15; Case map
			1F28; 1F20; Case map
			1F29; 1F21; Case map
			1F2A; 1F22; Case map
			1F2B; 1F23; Case map
			1F2C; 1F24; Case map
			1F2D; 1F25; Case map
			1F2E; 1F26; Case map
			1F2F; 1F27; Case map
			1F38; 1F30; Case map
			1F39; 1F31; Case map
			1F3A; 1F32; Case map
			1F3B; 1F33; Case map
			1F3C; 1F34; Case map
			1F3D; 1F35; Case map
			1F3E; 1F36; Case map
			1F3F; 1F37; Case map
			1F48; 1F40; Case map
			1F49; 1F41; Case map
			1F4A; 1F42; Case map
			1F4B; 1F43; Case map
			1F4C; 1F44; Case map
			1F4D; 1F45; Case map
			1F50; 03C5 0313; Case map
			1F52; 03C5 0313 0300; Case map
			1F54; 03C5 0313 0301; Case map
			1F56; 03C5 0313 0342; Case map
			1F59; 1F51; Case map
			1F5B; 1F53; Case map
			1F5D; 1F55; Case map
			1F5F; 1F57; Case map
			1F68; 1F60; Case map
			1F69; 1F61; Case map
			1F6A; 1F62; Case map
			1F6B; 1F63; Case map
			1F6C; 1F64; Case map
			1F6D; 1F65; Case map
			1F6E; 1F66; Case map
			1F6F; 1F67; Case map
			1F80; 1F00 03B9; Case map
			1F81; 1F01 03B9; Case map
			1F82; 1F02 03B9; Case map
			1F83; 1F03 03B9; Case map
			1F84; 1F04 03B9; Case map
			1F85; 1F05 03B9; Case map
			1F86; 1F06 03B9; Case map
			1F87; 1F07 03B9; Case map
			1F88; 1F00 03B9; Case map
			1F89; 1F01 03B9; Case map
			1F8A; 1F02 03B9; Case map
			1F8B; 1F03 03B9; Case map
			1F8C; 1F04 03B9; Case map
			1F8D; 1F05 03B9; Case map
			1F8E; 1F06 03B9; Case map
			1F8F; 1F07 03B9; Case map
			1F90; 1F20 03B9; Case map
			1F91; 1F21 03B9; Case map
			1F92; 1F22 03B9; Case map
			1F93; 1F23 03B9; Case map
			1F94; 1F24 03B9; Case map
			1F95; 1F25 03B9; Case map
			1F96; 1F26 03B9; Case map
			1F97; 1F27 03B9; Case map
			1F98; 1F20 03B9; Case map
			1F99; 1F21 03B9; Case map
			1F9A; 1F22 03B9; Case map
			1F9B; 1F23 03B9; Case map
			1F9C; 1F24 03B9; Case map
			1F9D; 1F25 03B9; Case map
			1F9E; 1F26 03B9; Case map
			1F9F; 1F27 03B9; Case map
			1FA0; 1F60 03B9; Case map
			1FA1; 1F61 03B9; Case map
			1FA2; 1F62 03B9; Case map
			1FA3; 1F63 03B9; Case map
			1FA4; 1F64 03B9; Case map
			1FA5; 1F65 03B9; Case map
			1FA6; 1F66 03B9; Case map
			1FA7; 1F67 03B9; Case map
			1FA8; 1F60 03B9; Case map
			1FA9; 1F61 03B9; Case map
			1FAA; 1F62 03B9; Case map
			1FAB; 1F63 03B9; Case map
			1FAC; 1F64 03B9; Case map
			1FAD; 1F65 03B9; Case map
			1FAE; 1F66 03B9; Case map
			1FAF; 1F67 03B9; Case map
			1FB2; 1F70 03B9; Case map
			1FB3; 03B1 03B9; Case map
			1FB4; 03AC 03B9; Case map
			1FB6; 03B1 0342; Case map
			1FB7; 03B1 0342 03B9; Case map
			1FB8; 1FB0; Case map
			1FB9; 1FB1; Case map
			1FBA; 1F70; Case map
			1FBB; 1F71; Case map
			1FBC; 03B1 03B9; Case map
			1FBE; 03B9; Case map
			1FC2; 1F74 03B9; Case map
			1FC3; 03B7 03B9; Case map
			1FC4; 03AE 03B9; Case map
			1FC6; 03B7 0342; Case map
			1FC7; 03B7 0342 03B9; Case map
			1FC8; 1F72; Case map
			1FC9; 1F73; Case map
			1FCA; 1F74; Case map
			1FCB; 1F75; Case map
			1FCC; 03B7 03B9; Case map
			1FD2; 03B9 0308 0300; Case map
			1FD3; 03B9 0308 0301; Case map
			1FD6; 03B9 0342; Case map
			1FD7; 03B9 0308 0342; Case map
			1FD8; 1FD0; Case map
			1FD9; 1FD1; Case map
			1FDA; 1F76; Case map
			1FDB; 1F77; Case map
			1FE2; 03C5 0308 0300; Case map
			1FE3; 03C5 0308 0301; Case map
			1FE4; 03C1 0313; Case map
			1FE6; 03C5 0342; Case map
			1FE7; 03C5 0308 0342; Case map
			1FE8; 1FE0; Case map
			1FE9; 1FE1; Case map
			1FEA; 1F7A; Case map
			1FEB; 1F7B; Case map
			1FEC; 1FE5; Case map
			1FF2; 1F7C 03B9; Case map
			1FF3; 03C9 03B9; Case map
			1FF4; 03CE 03B9; Case map
			1FF6; 03C9 0342; Case map
			1FF7; 03C9 0342 03B9; Case map
			1FF8; 1F78; Case map
			1FF9; 1F79; Case map
			1FFA; 1F7C; Case map
			1FFB; 1F7D; Case map
			1FFC; 03C9 03B9; Case map
			200B; ; Map out
			200C; ; Map out
			200D; ; Map out
			20A8; 0072 0073; Additional folding
			2102; 0063; Additional folding
			2103; 00B0 0063; Additional folding
			2107; 025B; Additional folding
			2109; 00B0 0066; Additional folding
			210B; 0068; Additional folding
			210C; 0068; Additional folding
			210D; 0068; Additional folding
			2110; 0069; Additional folding
			2111; 0069; Additional folding
			2112; 006C; Additional folding
			2115; 006E; Additional folding
			2116; 006E 006F; Additional folding
			2119; 0070; Additional folding
			211A; 0071; Additional folding
			211B; 0072; Additional folding
			211C; 0072; Additional folding
			211D; 0072; Additional folding
			2120; 0073 006D; Additional folding
			2121; 0074 0065 006C; Additional folding
			2122; 0074 006D; Additional folding
			2124; 007A; Additional folding
			2126; 03C9; Case map
			2128; 007A; Additional folding
			212A; 006B; Case map
			212B; 00E5; Case map
			212C; 0062; Additional folding
			212D; 0063; Additional folding
			2130; 0065; Additional folding
			2131; 0066; Additional folding
			2133; 006D; Additional folding
			2160; 2170; Case map
			2161; 2171; Case map
			2162; 2172; Case map
			2163; 2173; Case map
			2164; 2174; Case map
			2165; 2175; Case map
			2166; 2176; Case map
			2167; 2177; Case map
			2168; 2178; Case map
			2169; 2179; Case map
			216A; 217A; Case map
			216B; 217B; Case map
			216C; 217C; Case map
			216D; 217D; Case map
			216E; 217E; Case map
			216F; 217F; Case map
			24B6; 24D0; Case map
			24B7; 24D1; Case map
			24B8; 24D2; Case map
			24B9; 24D3; Case map
			24BA; 24D4; Case map
			24BB; 24D5; Case map
			24BC; 24D6; Case map
			24BD; 24D7; Case map
			24BE; 24D8; Case map
			24BF; 24D9; Case map
			24C0; 24DA; Case map
			24C1; 24DB; Case map
			24C2; 24DC; Case map
			24C3; 24DD; Case map
			24C4; 24DE; Case map
			24C5; 24DF; Case map
			24C6; 24E0; Case map
			24C7; 24E1; Case map
			24C8; 24E2; Case map
			24C9; 24E3; Case map
			24CA; 24E4; Case map
			24CB; 24E5; Case map
			24CC; 24E6; Case map
			24CD; 24E7; Case map
			24CE; 24E8; Case map
			24CF; 24E9; Case map
			3371; 0068 0070 0061; Additional folding
			3373; 0061 0075; Additional folding
			3375; 006F 0076; Additional folding
			3380; 0070 0061; Additional folding
			3381; 006E 0061; Additional folding
			3382; 03BC 0061; Additional folding
			3383; 006D 0061; Additional folding
			3384; 006B 0061; Additional folding
			3385; 006B 0062; Additional folding
			3386; 006D 0062; Additional folding
			3387; 0067 0062; Additional folding
			338A; 0070 0066; Additional folding
			338B; 006E 0066; Additional folding
			338C; 03BC 0066; Additional folding
			3390; 0068 007A; Additional folding
			3391; 006B 0068 007A; Additional folding
			3392; 006D 0068 007A; Additional folding
			3393; 0067 0068 007A; Additional folding
			3394; 0074 0068 007A; Additional folding
			33A9; 0070 0061; Additional folding
			33AA; 006B 0070 0061; Additional folding
			33AB; 006D 0070 0061; Additional folding
			33AC; 0067 0070 0061; Additional folding
			33B4; 0070 0076; Additional folding
			33B5; 006E 0076; Additional folding
			33B6; 03BC 0076; Additional folding
			33B7; 006D 0076; Additional folding
			33B8; 006B 0076; Additional folding
			33B9; 006D 0076; Additional folding
			33BA; 0070 0077; Additional folding
			33BB; 006E 0077; Additional folding
			33BC; 03BC 0077; Additional folding
			33BD; 006D 0077; Additional folding
			33BE; 006B 0077; Additional folding
			33BF; 006D 0077; Additional folding
			33C0; 006B 03C9; Additional folding
			33C1; 006D 03C9; Additional folding
			33C3; 0062 0071; Additional folding
			33C6; 0063 2215 006B 0067; Additional folding
			33C7; 0063 006F 002E; Additional folding
			33C8; 0064 0062; Additional folding
			33C9; 0067 0079; Additional folding
			33CB; 0068 0070; Additional folding
			33CD; 006B 006B; Additional folding
			33CE; 006B 006D; Additional folding
			33D7; 0070 0068; Additional folding
			33D9; 0070 0070 006D; Additional folding
			33DA; 0070 0072; Additional folding
			33DC; 0073 0076; Additional folding
			33DD; 0077 0062; Additional folding
			FB00; 0066 0066; Case map
			FB01; 0066 0069; Case map
			FB02; 0066 006C; Case map
			FB03; 0066 0066 0069; Case map
			FB04; 0066 0066 006C; Case map
			FB05; 0073 0074; Case map
			FB06; 0073 0074; Case map
			FB13; 0574 0576; Case map
			FB14; 0574 0565; Case map
			FB15; 0574 056B; Case map
			FB16; 057E 0576; Case map
			FB17; 0574 056D; Case map
			FEFF; ; Map out
			FF21; FF41; Case map
			FF22; FF42; Case map
			FF23; FF43; Case map
			FF24; FF44; Case map
			FF25; FF45; Case map
			FF26; FF46; Case map
			FF27; FF47; Case map
			FF28; FF48; Case map
			FF29; FF49; Case map
			FF2A; FF4A; Case map
			FF2B; FF4B; Case map
			FF2C; FF4C; Case map
			FF2D; FF4D; Case map
			FF2E; FF4E; Case map
			FF2F; FF4F; Case map
			FF30; FF50; Case map
			FF31; FF51; Case map
			FF32; FF52; Case map
			FF33; FF53; Case map
			FF34; FF54; Case map
			FF35; FF55; Case map
			FF36; FF56; Case map
			FF37; FF57; Case map
			FF38; FF58; Case map
			FF39; FF59; Case map
			FF3A; FF5A; Case map
		]]>;
		
		// 禁止文字の表
		private static var _prohibitedTable:String = <![CDATA[
			0000-002C
			002E-002F
			003A-0040
			005B-0060
			007B-007F
			0080-009F
			00A0
			1680
			2000
			2001
			2002
			2003
			2004
			2005
			2006
			2007
			2008
			2009
			200A
			200B
			200E
			200F
			2028
			2029
			202A
			202B
			202C
			202D
			202E
			202F
			206A
			206B
			206C
			206D
			206E
			206F
			2FF0-2FFF
			3000
			3002
			D800-DFFF
			E000-F8FF
			FFF9
			FFFA
			FFFB
			FFFC
			FFFD
			FFFE-FFFF
			1FFFE-1FFFF
			2FFFE-2FFFF
			3FFFE-3FFFF
			4FFFE-4FFFF
			5FFFE-5FFFF
			6FFFE-6FFFF
			7FFFE-7FFFF
			8FFFE-8FFFF
			9FFFE-9FFFF
			AFFFE-AFFFF
			BFFFE-BFFFF
			CFFFE-CFFFF
			DFFFE-DFFFF
			EFFFE-EFFFF
			F0000-FFFFD
			FFFFE-FFFFF
			100000-10FFFD
			10FFFE-10FFFF
		]]>;
		
		private static var _instance    :Nameprep = null;
		private static var _createEnable:Boolean  = false;
		private var _mapping   :Array;
		private var _prohibited:Array;
		
		/**
		 * インスタンスを取得します。
		 * 
		 * @return Nameprep 一意のインスタンス
		 */
		public static function getInstance():Nameprep
		{
			if (!_instance) {
				_createEnable = true;
				_instance = new Nameprep();
			}
			return _instance;
		}
		
		/**
		 * コンストラクタ
		 * 
		 * @throws Error new演算子によるインスタンスの生成が行われた場合
		 */
		public function Nameprep()
		{
			if (!_createEnable) {
				throw new Error("インスタンスを生成する事は出来ません。");
			}
			_makeMapping();
			_makeProhibited();
			_createEnable = false;
		}
		
		/**
		 * 変換表を基に置き換えを行います。
		 * 
		 * @param  input 対象文字列
		 * @return 置き換え後の文字列
		 */
		public function mapping(input:String):String
		{
			var mapped:String = "";
			var length:uint = input.length;
			for (var i:uint = 0, chr:String, map:Array; i < length; i++) {
				chr = input.charAt(i);
				map = _mapping[chr.charCodeAt(0)];
				mapped += map ? map is Array ? map.map(_replaceMap) : map : chr;
			}
			return mapped;
		}
		
		/**
		 * 禁止文字が含まれているか調べます。
		 * 
		 * @param  input 対象文字列
		 * @throws Error 禁止文字が含まれています。
		 */
		public function checkProhibited(input:String):void
		{
			var length:uint = input.length;
			for (var i:uint = 0, code:uint; i < length; i++) {
				code = input.charCodeAt(i);
				if (_prohibited[code]) {
					var codeStr:String = code.toString(16);
					codeStr = ("00000000" + codeStr).substr(codeStr.length);
					throw new Error("禁止文字が含まれています: U+" + codeStr);
				}
			}
		}
		
		//----------------------------------------------------------------
		// 説明：  置き換え処理を行う
		// 引数１： 値
		// 引数２： 要素数
		// 引数３： 配列
		// 戻り値： 置き換え後の文字列
		//----------------------------------------------------------------
		private function _replaceMap(element:*, index:int, arr:Array):String
		{
			return String.fromCharCode("0x" + element);
		}
		
		//----------------------------------------------------------------
		// 説明：  変換表から情報を持ったオブジェクトを作成する。
		// 戻り値： なし
		//----------------------------------------------------------------
		private function _makeMapping():void
		{
			_mapping = [];
			var re     :RegExp = new RegExp("[^\t\r\n]+", "g");
			var line   :Array  = _mappingTable.match(re);
			var length :uint   = line.length;
			for (var i:uint = 0, tmp:Array; i < length; i++) {
				tmp = line[i].split(/\; /);
				_mapping[uint("0x" + tmp[0])] = tmp[1] ? tmp[1].split(/ /) : tmp[1];
			}
		}
		
		//----------------------------------------------------------------
		// 説明：  禁止文字の表から情報を持ったオブジェクトを作成する。
		// 戻り値： なし
		//----------------------------------------------------------------
		private function _makeProhibited():void
		{
			_prohibited = [];
			var re     :RegExp = new RegExp("[^\t\r\n]+", "g");
			var line   :Array  = _prohibitedTable.match(re);
			var length :uint   = line.length;
			for (var i:uint = 0, tmp:Array; i < length; i++) {
				tmp = line[i].split(/-/);
				if (tmp[1] != undefined) {
					var start:uint = uint("0x" + tmp[0]);
					var end  :uint = uint("0x" + tmp[1]);
					for (var j:uint = start; j <= end; j++) {
						_prohibited[j] = 1;
					}
				}
				else {
					_prohibited[uint("0x" + tmp[0])] = 1;
				}
			}
		}
	}
}