Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2123.outbound.protection.outlook.com [40.107.21.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEC347BE
	for <iwd@lists.linux.dev>; Wed, 18 Oct 2023 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="CR2rg+q+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRo3bUGbAoFGBCiH0AJu6r+BZP/rsROEln2rsUKBl8pXEawRHxIVFwpJTeHFY+PRJUxMVT0cZdYrEvTzoDH10cdKJlv6/HPj2xToAmLTm3nLEgzvDVMrlyCf2iiLhZlDamq20q1yjeg+X6hMxig5vlMMTrHA8JGeHgF9/VUFyYohVtf90WgwPM8v5Hl5EE+N9ElqfyjVtSE7K4Hsq+2mzPRrfk6YUeCGXS5DKAyLeU8dSklWpCtbuc5A6GbW3H/m3OfZtm1xwcMU4r5xmoIWLIVRlNoWZNs8LLfScRN/dl612flq6HfZHaxqHeHWMIv4qqj0tWyHNEzXQ1kn3W/OUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4/eDbR7sGRLzAM9x3JiutLLboSQw14j0s9YbfN+/8I=;
 b=ngTBsHEBPm8EVzU3QGSGg6OkyBiu2W02BLoXN4VuG1y5Icjk0nrepIzDq1dexwD2Hbb3iTR50uOxc6qwJAJ06Qt3BipmmwtPZwE26eLUzd5VJtyVQ0FkJVCafow35lmlnBWPeog6Y62weOJzp84bNnCbC+3+aYsfE96bZdfiWFI0jcp/Ogl2sgpjK+2MYbfq9bqLzdw01MM4I10HW/iHL6Z7esTWAGgJfk4Tt8XoozLg1mZqHBRdYnB9nqypiJnfpFM/1SXODelZpgH8k/uv8yFDVrMwvfCqLrWFpv0DQAzo9bhYd5W0IGbGt20m1185jiIVr5DG4Uah2kibGC6m4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4/eDbR7sGRLzAM9x3JiutLLboSQw14j0s9YbfN+/8I=;
 b=CR2rg+q+1cqjIpTSpj4u2UunPcbE1NLMrmLTdzwJrElIPa2s8LaJ3ycrqTi+LE7eao1klUzb+QEMm2f28TAwvgN50ixHrJiPHcHQS12KjSvINWW+s9Stq4Gd3j7jz2lLuc3z3ByRzCGxeOZM/9TKXdeLijHRnjNBr2nniDIXaN8=
Received: from AM5PR0301MB2516.eurprd03.prod.outlook.com (2603:10a6:203:9::7)
 by DU5PR03MB10562.eurprd03.prod.outlook.com (2603:10a6:10:51f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 12:27:26 +0000
Received: from AM5PR0301MB2516.eurprd03.prod.outlook.com
 ([fe80::f6af:ebee:dba4:195e]) by AM5PR0301MB2516.eurprd03.prod.outlook.com
 ([fe80::f6af:ebee:dba4:195e%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 12:27:26 +0000
From: =?iso-8859-1?Q?Pedro_Andr=E9?= <PEDA@bang-olufsen.dk>
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
CC: =?iso-8859-1?Q?Pedro_Andr=E9?= <PEDA@bang-olufsen.dk>
Subject: [PATCH] add AllowRoaming station property
Thread-Topic: [PATCH] add AllowRoaming station property
Thread-Index: AQHaAb5zK7LgjLNI40u9fxcSc16CEw==
Date: Wed, 18 Oct 2023 12:27:26 +0000
Message-ID: <20231018122534.33455-1-peda@bang-olufsen.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR0301MB2516:EE_|DU5PR03MB10562:EE_
x-ms-office365-filtering-correlation-id: 61127809-fbd5-4e35-da4a-08dbcfd59673
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u/2WXHrh7Fi6w7bHPs8LSZHjGsdS23v7e3ow716jHu8ymVUM9Sl8zSA2xZMhDA4EjmsvKnByoCl29QXJKMP6601hIhfBwYYvNWsXqwDw1dCQ/7zQU3EwBASUWwzaEl4Va8cCS1rOBLBYOKTjhiBZ7BYx00RSAUrTqshMHGxlWFJF3MLBH/tLreajjsUItspy3KigTnwXe0bW5ooFYpAjzpvoKJULIpQw6tjNIbZ0RYNLhxkcdThN1EgX6KfbAPc4strZgwbx/4zw+wPQcVkJCPqZJJB/d6g4GwMGpOTEzeZ7GM038AlpeA0G/g0VktINz9Dcqz5Hmd+b/C+zRfDZ0iIJNVOl2a4bSfZompoMeMT3KsD0JW+XOXnwJkjY++DoOCwNVCI9yabtuZxlGLB+1ijV8Wk+a35xGOEwXDSkgdOqzwJejoUGyZMJASFZqKbNZi2Tl/m5Z6vwz1uaHss6DIV5nG4umzEAeeISI5VnAnXmI/UZ5OOBFWKVXiUhqUVmt2sUOnOaPqEc4JtzI5a26TKb5mqD7973e8lMYsr0S8t63Lyg2CIctAIWJu3bzq3tuIqC1H9ToeTqjWNYRtjRj9/m/OqTdZQxNQs6TaX3KAJQmbXPaSoloxbnxsVzDLY8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0301MB2516.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(71200400001)(6506007)(2906002)(6486002)(478600001)(8976002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(91956017)(64756008)(66946007)(76116006)(66476007)(66556008)(66446008)(316002)(6916009)(83380400001)(36756003)(38100700002)(26005)(122000001)(86362001)(6512007)(2616005)(38070700005)(107886003)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sNcxgYTbqUxftqRCNu4MDEpcxitcVINTox+sQ1UY+xqEFHTwFW+ivpCcaG?=
 =?iso-8859-1?Q?wPbmRjP55QaXS6dJHIU08RSahBumUCG3PIOdj8wJWtXTwDPuMAvLbD1GkR?=
 =?iso-8859-1?Q?qo89y8bq+vpLoZAm38as32famBKXPQlCOPft6I9CcDDPqAtDsakzGMAHve?=
 =?iso-8859-1?Q?2XqSEqHmD0tBjuGvNGr3KAvb8kkEiQ92Q04l4G3VB8P9nGEhvzPP8FUG82?=
 =?iso-8859-1?Q?CaeDCcASbv8duyLBlERVkfT4DMNacKT+rPXKR5PiEVCcQtYdsiA3K56pfa?=
 =?iso-8859-1?Q?iqqpXTaF9e4uCNvZ37UDMkm8GgnCo3dQJ4gsMFILwPd8twDSkqt4ilU1LK?=
 =?iso-8859-1?Q?1TFX43oxvPQgWC3yveGvT207bvLoMX2pGXavxm8VuF6WDon6CkaMr44FWE?=
 =?iso-8859-1?Q?4/oPvZ8CjrtdyjZxbs+ug0LzaTufyLPexlGWo9mikvzmEvPCYp8d9Ror3P?=
 =?iso-8859-1?Q?sWz+g5Vwp3Ux3sJRMGyd+wcyiN8eponNHeh64Wc/ZwrIIFdQfi4p7QlQBu?=
 =?iso-8859-1?Q?4BgaYAgb6Y4ZnpQ0C2+LV2DPgnjtGbywoP9r8yGjZGFicIbeabmINelBOL?=
 =?iso-8859-1?Q?jq1lHD8UwyadAKfUG6s+jNMrwA9ijk2iQ2WP3HYEIK8NvE5IbmLt8aBU7r?=
 =?iso-8859-1?Q?9/pKr0/6NIc6NL2tpa8n1N9z3M196G1r+3pHTpeZ7Xw+MxHxVBNhXk8/Vr?=
 =?iso-8859-1?Q?g2yAOdF2TwpID+mxQe5sC2X+BJ0wQnRt6MIE71+CYIhXCtfXqXuc8ETwnb?=
 =?iso-8859-1?Q?4kirtqpqFScM0IyipjppmRkE57UFgRWrfIYQbMoAE0cDhvagKua0KBh5CZ?=
 =?iso-8859-1?Q?MqIGXXEODwYkLgyLHMiuEDeHzvL1mxaMwfU5hwYg/LceA1cZjIzerksJkz?=
 =?iso-8859-1?Q?6ncDw2RaymapHczlVpZY9kylV9UwJWFP6IkFu/had+r7VtdvRthsSjUPIE?=
 =?iso-8859-1?Q?HcuWhlG0dX9Ao5XrHZeFncDeBUXV5mPOniXvZovcoX77/qZKyEYFaFo80N?=
 =?iso-8859-1?Q?7g1EsWK0DTD1mRe0gerTxSnCKUfD1ZM8+0t+UqjOnZFJOyXfHC4yXAHUKj?=
 =?iso-8859-1?Q?ABU24vQ5HWD5wCBgPzaYCQpPMoWId0JYjK1bBCH15LMbCFaNdRwRprUq07?=
 =?iso-8859-1?Q?giXm3+hFVYWJf33m420M2uHWYkBlv8LhJXWHzn45Ejk9ds56cb0yZ4wXff?=
 =?iso-8859-1?Q?rI2vCQT4LXhB3n1Ca7EKiuffeFH4f94SWZvxTEw9lKo2ISpcBrfnwTWFG3?=
 =?iso-8859-1?Q?fHd16Sp/Djg9bKkuk436jWVTsphPIVRj4k1cZbI7kBp+9u1wQK1EBL4ruP?=
 =?iso-8859-1?Q?yPvtuxxSZd//ZPSscucuFdn2oeBK353WreIv090k4CXj62h1xxcjnKeGK/?=
 =?iso-8859-1?Q?lZQLbtaHjhifz20Antcif3tdGRabRCM5l2B5nSbpe4ury7ICIlRJlFbdja?=
 =?iso-8859-1?Q?sbM8sovZkRraoqJy1u33P3JyPLa9BLvV7zS6jn6l6DqKBfMUSOlhBvEKBx?=
 =?iso-8859-1?Q?yhiImEwNIHrb8Bn+iOfhnHktluXVa9CJvbsGkgUVkkyVXScWPgMQm98D7/?=
 =?iso-8859-1?Q?eDy2u5+/OZiniJH3SNYpLaYlVxMv+nR2Bejo2E+cBzfYy0QaZDe7Jl/rgK?=
 =?iso-8859-1?Q?0FiSqq6SGWUGhFZhbqZdJmtuvPqCWzgiHhgMQGCLq/RAidQWqwR3z/WQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0301MB2516.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61127809-fbd5-4e35-da4a-08dbcfd59673
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 12:27:26.1972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkkcHhMx6/rPfJuAn2fY7vE3dCP2mzvex3sKOvTCnOKyOx4ucVhY4pdOjoDVlQmPqOqsQceTNWIPD7j4mULRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10562

From: Pedro Andre <peda@bang-olufsen.dk>

This adds an AllowRoaming property to the station struct that makes it
possible to indicate to the station/interface that it should not go
into roaming state (when set to false). This property defaults to true
(i.e. it defaults to the normal iwd behaviour that allows roaming).

---
 src/station.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/src/station.c b/src/station.c
index 065687d..00254b7 100644
--- a/src/station.c
+++ b/src/station.c
@@ -130,6 +130,7 @@ struct station {
 	bool autoconnect : 1;
 	bool autoconnect_can_start : 1;
 	bool netconfig_after_roam : 1;
+	bool allow_roaming : 1;
 };
=20
 struct anqp_entry {
@@ -2754,6 +2755,9 @@ static bool station_cannot_roam(struct station *stati=
on)
 	const struct l_settings *config =3D iwd_get_config();
 	bool disabled;
=20
+	if (!station->allow_roaming)
+		return true;
+
 	/*
 	 * Disable roaming with hardware that can roam automatically. Note this
 	 * is now required for recent kernels which have CQM event support on
@@ -4155,6 +4159,38 @@ static bool station_property_get_state(struct l_dbus=
 *dbus,
 	return true;
 }
=20
+static bool station_property_get_allow_roaming(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct station *station =3D user_data;
+	bool roaming =3D station->allow_roaming;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &roaming);
+	return true;
+}
+
+static struct l_dbus_message *station_property_set_allow_roaming(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct station *station =3D user_data;
+	bool roaming;
+
+	if (!l_dbus_message_iter_get_variant(new_value, "b", &roaming))
+		return dbus_error_invalid_args(message);
+
+	l_debug("Setting allow_roaming %s", roaming ? "true" : "false");
+
+	station->allow_roaming =3D roaming;
+
+	return l_dbus_message_new_method_return(message);
+}
+
 void station_foreach(station_foreach_func_t func, void *user_data)
 {
 	const struct l_queue_entry *entry;
@@ -4358,6 +4394,8 @@ static struct station *station_create(struct netdev *=
netdev)
=20
 	station->roam_bss_list =3D l_queue_new();
=20
+	station->allow_roaming =3D true;
+
 	return station;
 }
=20
@@ -4484,6 +4522,8 @@ static void station_setup_interface(struct l_dbus_int=
erface *interface)
 					station_property_get_scanning, NULL);
 	l_dbus_interface_property(interface, "State", 0, "s",
 					station_property_get_state, NULL);
+	l_dbus_interface_property(interface, "AllowRoaming", 0, "b",
+				station_property_get_allow_roaming, station_property_set_allow_roaming=
);
 }
=20
 static void station_destroy_interface(void *user_data)
--=20
2.39.2
