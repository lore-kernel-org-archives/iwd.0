Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521117;
	b=T8G9xGcovAkvrXWL0zBw0uycdWi2P2xvQRoMkRJeqvUdsYKHAIJ9lnnqNm0cZMzE9+A6
	 Ynoev6STI3/PDFoWzex9VgNJqJlgOW4qp1NXJ7eaSCt3KlxR6kO18o9wWehThn90odnh2
	 F4MPgCljCOTQiQexH9a6j/CMGq8dramH61uWRtgv4dUpbOvGezFC34QzR0jr6SqkIdzKe
	 K1gZUn+FfNbk21ptsrvI/vFeN9uBb/KoV/JgTLeoGLXlHGfXp3kpIoeaBm2sC1hvgnWte
	 oAC8XPZtn3dOw0USCvquI3dxtxQXKUyGqSMZJ0wFAn12RbmcFgUP4+9UFbsqV+pul6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521117;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8D051W05XTWkVBqzveJRiEJ6VH/l3PkeCVjUeofRO9A=;
	b=TapohoglknAnA95xQ8oYmnCvzAMhvFgQhKBGBRQBNIhC09HLpJC36U14b+uLhffuCkSe
	 ibCaHr2LlXKjQzmqHX5Z8tGFMLmycvaWb59+Y+4eSzc1rk+TvJi9iFS7wBvCZFeFr7++/
	 MwZNvaIdLvExseim51Mac99dH53bZH7WX/01fiPLBx/lwEsan228j0hTQVM4bCvp92+m5
	 YQeirBCXvSzHW0SJzQMykASWLRiX+R2WuDjmAE10y92LQkb1uDqmTvQdLLN+7S9Pqyw3i
	 o6hv/Ouazv9XG4aWzX3OXQY6c+5v9GAE6P0aJIG/luRSzL8VbbOAoxK0u9pQFFJiU0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kuleuven.be;
	spf=pass smtp.mailfrom=kuleuven.be;
	dkim=pass header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=veUqo3MZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.109
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021109.outbound.protection.outlook.com [52.101.65.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A7606A32D
	for <iwd@lists.linux.dev>; Tue, 24 Nov 2026 11:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C74A7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuleuven.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=veUqo3MZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7OxqLwZWWJJh4vPaY06UoRGvjer1Ap4vb6/p5Zen9CqkC1jMESrNasjtbRdzLJiawqQId0KATg33Tk+5dtgnwIUA2LcnsVdcHArzTEd1mo0gvgHkLtAStfy7OB2dm20KAHa5xTkEyilJ4J4YpcbZ/wQLfEow2mK1145G5Ip6cHpvex8ajHm1tY3CssTJ4P74YrrATGuATf/i5R3j3sPnk/okGzKJtwYfK8CDv481iyu6Nu7qmAc3k3+BHSYgmBISUF+NEqVcp05J/ip5xgPZzAw5U5Box52D6NrRj5/P1ET/sTTNJPBLLXM8j37FTICKxKZ//zrBq8mKv0jVEXslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D051W05XTWkVBqzveJRiEJ6VH/l3PkeCVjUeofRO9A=;
 b=Y5arQvqN/VXrgKpMKYDIm/1k7jUacwRUjjJlOsY/6AZUzT8bGAE5VtgiipT/St/qFVYmndN9pO+yrDFPMPx13qzqOrAdLKOjxUlmg/t4gZDP8pQHAVP7+f/kLwrz0Uf0H9sZrhYBU+PcMkuAH3iKCh1suQeAFPY5ZbXsXvUKjiQUAr2HupCUfkb+qKSWJdSQog/wkI5Sc85JYDGfm/qIZZCU+SIrqqCT1NkHn4aq6NAotCFuaVw6NrvSw+bIrryBSgs8BtyXF6H99538F1OIhKgWfNsrdPPmDUwXTQk2xw7rOtkXdkPs5UTDLDLpg0Ha48vCZ1O/ABB4SMcjBUo/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D051W05XTWkVBqzveJRiEJ6VH/l3PkeCVjUeofRO9A=;
 b=veUqo3MZt6tz8lyIphi2Ae9qsjj8q3bmq1MbAjbC8ApsRzh4Q5h8KVpExD9nzXDI6fJaZYMeHeqDZwzqGnAOO/5LhbxlAE3hkeoVpUrMVAnxXh5DyWEVaNFgj+s9mqRCvcmz+R4XF03J+OA2QB2ecNF+s8N3E/43w1iQQxtJKbY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16) by VI0PR08MB10711.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 11:51:53 +0000
Received: from MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48]) by MI9PR08MB763857.eurprd08.prod.outlook.com
 ([fe80::4f1d:a35e:c1b6:8b48%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:51:53 +0000
From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To: iwd@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	prestwoj@gmail.com,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 2/7] doc: document EAP ServerCertHash setting
Date: Tue, 24 Nov 2026 12:51:41 +0100
Message-ID: <20261124115146.1281715-3-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
References: <20261124115146.1281715-1-Mathy.Vanhoef@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::9) To MI9PR08MB763857.eurprd08.prod.outlook.com
 (2603:10a6:290:c0::16)
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Post: <mailto:iwd@lists.linux.dev>
List-Help: <mailto:iwd+help@lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iwd+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR08MB763857:EE_|VI0PR08MB10711:EE_
X-MS-Office365-Filtering-Correlation-Id: 1949c41e-51a3-423e-e2c7-08df4a215554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|786006|376014|366016|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	57IXE6fJ2E4UqeEM1ZY9X4cCaOSVuRDEETR/GQReTOjCAIvCa9fvFoqBhvmDydVrwWXDpfoubPwR9/0UQHG+g95drGVUEW+MhTtHYgaUg1F5oLxqMFhb6wmFTNQTX2p771boaSvwnN+swnb5D4UGfVDWI/0s9QrUjevaefD5B2pgZq4yjRTMffTZ5f17+KA7F9XzV2M8Dy801PAN08eIeMNP6fdLH7uv2KG3LvfwSUJKoRi9+HY1/qTzPOH45FmSStfyaYTVybxQB21BI5Gey97yLVbasHOpTciDznQ3Q9D3r7QP3DMajOTcWzmY07/0Ru1jVqrQ2HpJyqtwMozGGl3w5Obf2vZb8z4c8qd7Ikynyv4ZVM8p0kYuZvPOw/1yFdz7W/fCGRkV7hdX9SLs4MKSIxGnn/bE52UFWTUgW6aY1bpMvADavJ6W+3oTjERu6xA1XA7O/LmqXwkaRvKmnDj5x2H3ZDnW65XXPhgeIJoczETI37lCDJfsBif5w9SzyxZe9kWtGOtZp2Q2SYIl6z2QelaFtU8yemIzRaCUze+EsIwE31lojRmuy1AhraoXWShUCirxLtFvDIxMe/abCk7smHK/aV+gN1nuTErt/nvkvjiWCrvItV8CXVijAbNRaBWnjfX4x0tCY/c23bN4A2ySYnxFlaJp0cqmdxIf5SE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR08MB763857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(786006)(376014)(366016)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SIqxNnQpK0BWSEm7UeGnjbD/SQOKdhwAy6r7IP4JlSqPuADZw5pNKUxQzAu1?=
 =?us-ascii?Q?N3JP5HXEiW/akPnSAqf7TV9FxiVsBbjORtWw4T2TUWYOKqZchGeWli6A057Y?=
 =?us-ascii?Q?bME1jHllvO4y0KIxb82LQjKIDTYtUu5qRNT/OvOGr4rftzgeZkMRG654YbI8?=
 =?us-ascii?Q?9LFsRgWfs9DYdJ1p67kKc09ZcZUtP0+VMy1XD5bgoQf6wP6bV8kPS8JMzxDr?=
 =?us-ascii?Q?cDm/M7jv/vzql8m9bLrQebVta2CvpoMgPArBMSl+ZKmBNXZPIyS9HaBWCROI?=
 =?us-ascii?Q?K2Lm5saaOKODa9OXyE3vdAIY0jRNNvjNTs1231xLm8rsT8PTfjB/TRQtdh/5?=
 =?us-ascii?Q?mfF52lrbP8z7AFsRr8Yi/tnKePyGSG0aw6HRv/rQIJNb3hg00TPhchj00Ih0?=
 =?us-ascii?Q?JIUvYBhbspOjijNJE/eIGKBdXH/2bBHKd9jEsOC9gFsBdkgvls4eR+tgOCk/?=
 =?us-ascii?Q?Vjl7duWHqzLTqSjk+SUo9eQjIxz860ois+QIC55gq5RiavVyEhc4muDwpdGt?=
 =?us-ascii?Q?4SRln6rosrjq2RFl7ANI9yE12T+aNs9ciiDN4i2gbn7taZ/ntvBYt0NFrrpY?=
 =?us-ascii?Q?bAL7gZyPFeUJGBKdYAP7zVP8y3yrkymbA/tIPMit3p0r+vbgx+hvsocHowJX?=
 =?us-ascii?Q?DBTQpsFZw3PHnGxFlL77QFP6YjBgccEI8AIJK1v9IPpOadVsB73KkPEiyjDX?=
 =?us-ascii?Q?hqX+yecDrIrD3/9r3YRUKqI8lxjLZQ9axDLycZMVc/zmG6Lq3aQS27XkKHmZ?=
 =?us-ascii?Q?VsXkgz8093O04P48impl8dCc8cYeq23RF2/rwuGICLcrSZ4hsBIlZLrUPEo+?=
 =?us-ascii?Q?tayeLjvDREFhnsn86cJaoJLSQdQUzc/OhPhSlW2d77WXnNc8LO3Tne70ZF44?=
 =?us-ascii?Q?hx/9mL05PGGZQqz66HMKXw76EUztWVYWXlQ4aV8Wu3oTSXW3CUlGR5vgNZfn?=
 =?us-ascii?Q?cmbxCEE5g0in+2egBJ0qE+TFaiZUFyKlUmhN8ll/qbBIA8hDWshPLRcsISu/?=
 =?us-ascii?Q?2YdHGoSuURC3C4RiW97Dzw3HFwJPBewaOrsR8Qo++qkYCXEzrC059zjKm4Ot?=
 =?us-ascii?Q?bTQKZwwcbgiX7A41s1+khO4vV0w3+SgCDW6cbpD3f4P17KgWr1We6GgFmzfk?=
 =?us-ascii?Q?05C35vZf7xwT2rtHkFeadCq8OKZVUt4yAaR8iAtxlyRQQM2/IjMS7ZvmbIQq?=
 =?us-ascii?Q?FxWaxXmW3o93MXYqXr/ksk0DSDfOYzD2/Nw51pz6/ViI8z8zTUwtoYA2PEgG?=
 =?us-ascii?Q?q+t4+GCo+xNTzOMrZy1pYiMPFcJPLS2vlvHbRnfIw6g0z0JP1iZUKOrBB9MG?=
 =?us-ascii?Q?2KFDmaUJVLiNB+dQMDHmIMB4RwcY55Kn7A6Z+8R+ec8ylm8afS00yLC4oqTw?=
 =?us-ascii?Q?hCU5yarTVZ2Xuyvw6vm1RlcsvoH6baTtw0bfuUvms+al7jDb5zfqPi04BHQd?=
 =?us-ascii?Q?x+FM4mdEsQGesjJob8oxdJx9G05+l2hQnfv2pJrSB+MBINErThUbqabhP/cw?=
 =?us-ascii?Q?7yKurigvAXpSvftKE8aZjWSKAM8eupZuWLg/5jTXKqqeBbWE8e1dp/pUAC6A?=
 =?us-ascii?Q?Pgp8v9xOVdJHOHYr90qotw6CQN4GID4Lg7/hA55GnO8aNJW12VGLJjmXfh1Q?=
 =?us-ascii?Q?6SwbomNESlcvpSOb0z0TbwcTHsqdSWlv3Pd9/Bvf3wJdJMW3m6ysj9SkJPap?=
 =?us-ascii?Q?DbvEt67Lb9l4dyrq9pzZRvgXySHrLwGPU2VNTrMnfi9ACnv2hRbCcAXwuG3p?=
 =?us-ascii?Q?llxr20xYHAlCxqi3yssvfxS9P+rz+dmwF3Cets7tWEj40CYLAY8m?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 1949c41e-51a3-423e-e2c7-08df4a215554
X-MS-Exchange-CrossTenant-AuthSource: MI9PR08MB763857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:51:53.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5WFE43PFnT2SfB8s13tR//znP4uJjUzV2wm6QSBzLPefkcNjuHNbvHYepGIO6ghMu7AO1Z86g+KMCJg7TTSkN9sz/aNSyVFYevV5HwFeVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711

Co-authored-by: Rathan Appana <rathan.appana@kuleuven.be>
---
 src/iwd.network.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 892c6eb8..dfc3636e 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -256,6 +256,18 @@ connect to that network.
        certificate chain must be verified by at least one CA in the list for
        the authentication to succeed.  If omitted, then authenticator's
        certificate chain will not be verified (not recommended.)
+   * - | EAP-TLS-ServerCertHash,
+       | EAP-TTLS-ServerCertHash,
+       | EAP-PEAP-ServerCertHash
+     - SHA256 hash as 64 hex digits
+
+       Pins the authenticator's server certificate: the SHA256 hash of its
+       DER encoding must match for the authentication to succeed.  This
+       authenticates the server without a CA, in which case its issuer
+       chain is not checked, but the certificate must still be within its
+       validity period.  If CACert is also given, both checks must pass.
+       The hash can be computed with
+       ``openssl x509 -in server.pem -outform DER | sha256sum``.
    * - EAP-TLS-ClientCert
      - absolute file path or embedded pem
 
-- 
2.53.0

