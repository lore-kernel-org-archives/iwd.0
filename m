Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013055.outbound.protection.outlook.com [52.101.83.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C2316180
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330918; cv=fail; b=A/BQJIQGoZ2e4OniFP6dkjTbTXwdTPj/Urz+ukFWWRGI2c9dTE7IXCRGBqDj8Sle6/HTQN2OFr1ZufdEpNJ0jmYrZz1XPRjDYhc5Y3iAgsV48o36ga7xPN5NvghC8qVW6QZOutTzEDYbdFTDNDCmOrgxZd78zpFCv0U+YUm8YkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330918; c=relaxed/simple;
	bh=ppM0NLns+s+djsPZt3vDYLM/V9ZpvkJ3f1VwlCK/vkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To; b=huqzz5ixPXs4ldyC/tZLD4DCZGhAY7Ul/q6IxsmldwUHYNTo29pcqNxXEPIFV6CxmmtG42F9kLMAFtMXWjWHhnawp3W7QpaUrOLRL31AA6ENHMKT4pY5hR4NbmZsUzB9gUVPX6/6odA9m6VFvend7FRlG5pTnWsbT43i2LpAhGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rbmndM23; arc=fail smtp.client-ip=52.101.83.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rbmndM23"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8CxqqSkHgutkI/ZLHLmow1+yPBXUWmALNG4LuLld4xjbah8CYkygJz0xTUmb3onGUZ6i7qgCxJI2L2s6q5Zy2vcG+msWgs3Ib5+pOzDgqV40mqWT+KoIU8Dpo2mY3lsqAmTXcCKtepIVGysAel8PDiaJsWDDS4UvAoujechB3FSFpMCC+5tb2Cr9hG13Y5+ICVAt+YUVMWUG1RbgbLFrH7B5S23oOQR1c7VOY2odM2evUa+KCn/UQVZ8mZj55B4OjKdocEAXjD0MHmslMyuj1FGuDdknehlVCueyvw1Mt3TCUptBub+XTO2tAVEsP+F0SW5vcUb2lTdkIHbLuKQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSLL56cCWlzM0MRhAga3eTrd9McHXK2ygqLcT6moPyU=;
 b=uMf+cLKrrqAvRr/syVe0sUiwi8r/cvHe7TOtY+qnGfRzma5nxvElecdJ3b8hbj/rrM7Qvo8bKfQlfOe7HM6qz7Ok4ww4YP6X5/B3hgHmM1pagFwdpEjO6ci43ixoAgD6OIJLVs/9FN7JggXb0rhTtLMJ3PGUDm7rkxKxVtO2gPsiy8qdikh7geMp5d/PyYzGvPvJIV8zhG/XIMLYVGn6+Dm/z0+0M78IymtgRnG8tWVYsCg+BtuhjYfY4FutWKkk8esGcu8KrBojflLGibyifwPli7dDmhQgalXzc1VgsxXyR/zsJivpnTuzfvxBdl7DZAlXzySv9Y6ZxANNwfTh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSLL56cCWlzM0MRhAga3eTrd9McHXK2ygqLcT6moPyU=;
 b=rbmndM23MdtTBtCmzOpEr4KGpYegb4tMU8dxkK+yoNUgUneyDaOhrG83AschbkDoHPb8bDnc9NBMYhMgfJ/OreVTytw3ayOOZZY4XC9wr1yH7/FkWKJrGHwoJ9rXs4RiURInbtOhhpzwu+6VNq01eZXZO6OxDzaXjjE1GcJNNJg=
Received: from DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) by PA1PR02MB11542.eurprd02.prod.outlook.com
 (2603:10a6:102:555::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Fri, 28 Nov
 2025 11:55:12 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::5f) by DUZPR01CA0028.outlook.office365.com
 (2603:10a6:10:46b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 11:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 11:55:10 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 28 Nov
 2025 12:55:07 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 28 Nov 2025 12:55:07 +0100
Received: from pc48844-2217.se.axis.com (pc48844-2217.se.axis.com [10.92.172.48])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7A55A936
	for <iwd@lists.linux.dev>; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
Received: by pc48844-2217.se.axis.com (Postfix, from userid 13016)
	id 7920B286516A; Fri, 28 Nov 2025 12:55:07 +0100 (CET)
From: Alexander Ganslandt <alexander.ganslandt@axis.com>
Date: Fri, 28 Nov 2025 12:54:28 +0100
Subject: [PATCH v5 7/8] auto-t: Fix test_ignore_candidate_list_quirk
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251128-roam-scan-improvements-v5-7-285ff0104188@axis.com>
References: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
In-Reply-To: <20251128-roam-scan-improvements-v5-0-285ff0104188@axis.com>
To: <iwd@lists.linux.dev>
X-Mailer: b4 0.15-dev-c25d1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|PA1PR02MB11542:EE_
X-MS-Office365-Filtering-Correlation-Id: caeb9e7b-23b3-406a-ed23-08de2e74fbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajNlZi8vZXNSU0RvYUQ0djJJaDh5VnV6QUl0Ujc1a0JLSnpGczBjNU1CVnd1?=
 =?utf-8?B?SHZqcXhVN3RibWhwRHVtVFdsTVk0N3dSbzRlMy9aYStCN2hKeWhPUU02MVhS?=
 =?utf-8?B?YklaTXk0MFI3U2RxWXUzL1lqNEl4NzVid0xzbm1wcklXYUFJRUZza3o0eERn?=
 =?utf-8?B?Mkg4UkJpYTVNaXBaUXNWZjBtaVRtQk9vUUFzamFpQy92cWxVdXFIVjVmMU93?=
 =?utf-8?B?NlU0NU5HeFRCL1JocjlIYTUwWmhrcHE2RkxpTDNacFphaXV4VS9GTDJpNEpN?=
 =?utf-8?B?M3owbE9TdkNMZ0s2a2FQV3BDTmNzWFdLS1A0MFhvU2ZzVkJ6djNUUTAweEdB?=
 =?utf-8?B?b1dXR2E3bWdGdnVQSnFjMjNidzRsQW1BKzhjcDZnejEzZ1h6Zk9JTEVadHpq?=
 =?utf-8?B?czAvV2VJYW5nUktOKzdPNHVpbHhqU3ZxbC80MVJ3cjU5ZTlCMnJST1RoU1I1?=
 =?utf-8?B?NWhMb2R3UzBId3JIVGM0ZTBpanpNSnAwZkpCaUJtME13L2pTU1ZqSTRTL1Qr?=
 =?utf-8?B?Y3F0N1ZMREU2WkdSU0lpckJuRlFVSGdhUXJURW5laW9DN25xdW92YnFqbHNS?=
 =?utf-8?B?clE2WmV0VnFzLzl3b0k0UEJOM0tqZVQ3cGtNdjVod1RvL1R0U1ZSUU5paTFK?=
 =?utf-8?B?MitBOHRaTi9KMFN3MnZKVFJHVUJiejBEU0VIa2JNMUhGcllDcmNQZ2dpbW1T?=
 =?utf-8?B?TCs1WFVhRXg1L3FUUGxyYWUzNjdYY0JZcHhGZ3FtekxBREM4Uk5Rb1VKVWdV?=
 =?utf-8?B?VFFVNHNPcThodnBwd2dtZkhKNXcwMzBNdno0TXlTaWZxMEFSbGxDTC9ESHZw?=
 =?utf-8?B?ZVhMMFVLSkg1ZE4zTVRzNS9ROW80L2poTHNQRmRVdU1YYTkxc1NZOWZWNmtr?=
 =?utf-8?B?T2lIbXFXbnpCSUhqRVFjWDN1djFVbEkzcVlWMExQdHFuaWFqSHh3cUI5UDZP?=
 =?utf-8?B?aUt0OE9KcCtQQWREMkd1bFN3OGN2eDlwSFI3RmR5cUZSZ1hNa2UxTWpEM1BY?=
 =?utf-8?B?STZDNGk4WU40eWU4eHNGZTlJdUJlWjNTUTFnZlJ2clVMWFUrU2VRQTJzczBL?=
 =?utf-8?B?ampobzJRY05BUUJTZ002QTM3bmlCcC90NHY2dW1CYXJHUCs4ZlVQbzdTT0Na?=
 =?utf-8?B?aGp3ZVJtb3NqNTNZOFIvRGpmSkpFeSs2MUJuRk40SkY5bVlkeG1DTzBZZFVt?=
 =?utf-8?B?TXgzUHJBZGdTSHhDRWVzK2dZbUxtQStPVlVRNU1OU2VRQVdiWm9iSHJua3pM?=
 =?utf-8?B?L2E3TUJpQ01ja0hIdE9ZZS9hYWMwTGxyTUpPY0lpekRZN0VaUld5Nm9jVFp6?=
 =?utf-8?B?WnBWK2QxUmEyc3NlTndhQU5VaU11WVBPZlRSYUFLa2h3UUFZM3RMRTY1Y3lw?=
 =?utf-8?B?di9DTjFjd1RvdlpuSGhuK2l1bktLODZkbEhqY0tadTNqeWxHUG5KaWh3K3pZ?=
 =?utf-8?B?d1R2aVlDWW1UNjVhR1dNLzFXUVpDQ3dEM1YrUjNyeURrSmlEd1oyVzJNQU1w?=
 =?utf-8?B?ZXpuRVJnb0VnVzlZdVh3cUQwK2JVMlZmOXpCYWRVOU0rTlZNREREUXIwQTVJ?=
 =?utf-8?B?QmlEeGZFaFdCYUxhb1VtTHhpN05Ub0ZOczVtSjhJU2M1cktVdDZtbWhGcmxm?=
 =?utf-8?B?VWNZVUsxamJyTWlMR1k2dEpGQnU3L0Y2eklLK2VLL0dSM0JPZEdwT2JLY25s?=
 =?utf-8?B?bC9WUFdiV3RiY2hCQVJyWEUvbThmcnZpc3VHVytUNy9mVkRGeWh5WXhtUVRD?=
 =?utf-8?B?QkFhNVdMNmgyeG8rUmdzOGFoUWs1cGpVSi9Kck5ud0NQWGJuTnRoUzlnTE5J?=
 =?utf-8?B?WnVqdmpwQXovUzhrNm5LbVZTd1dVVFd4STlPaE9VVVU3YTFkU2Z4ZUhQdkhn?=
 =?utf-8?B?ZHRFVm9reW1YcndIamJlaTFjOFAvT05FZTVsYVpFN3IvWEtGYk9rdXlTcXBZ?=
 =?utf-8?B?cktoR3Q1MFE2VTNlWjJ6Qmx0bHJna09va2JHRWhBOTBsRGJvREFyWnZob0hz?=
 =?utf-8?B?VzhsM1pta3FxbGE0c3hGRkhja3A4OEpmeDkzdnNqYzhIZWs0OWUzTGhwUkVI?=
 =?utf-8?B?aHlkNENVcm9CRXF1Y2NDS2k1NjZONnJ5RlFiY2tkWFRRTmtGTjNjOHExOG0w?=
 =?utf-8?Q?EA3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:55:10.6456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caeb9e7b-23b3-406a-ed23-08de2e74fbb1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11542

This test no longer triggers a full scan. Instead, we verify that it
doesn't scan the bad candidate channel, which is verified by not getting
"no-roam-candidates". Then we also verify that it roams to the other
available BSS, which it should do immediately because that BSS is on a
channel that's in the first subset of channels to be scanned. This means
it should roam directly without getting "no-roam-candidates" in-between.

To allow for this, add an optional "disallow" list of events to
wait_for_event(). This functionality already exists in hostapd.py, so
the same solution was copied to iwd.py.
---
 autotests/testAPRoam/bad_neighbor_report_test.py |  9 ++++-----
 autotests/util/iwd.py                            | 13 ++++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/autotests/testAPRoam/bad_neighbor_report_test.py b/autotests/testAPRoam/bad_neighbor_report_test.py
index c8e4e45a..5a8be635 100644
--- a/autotests/testAPRoam/bad_neighbor_report_test.py
+++ b/autotests/testAPRoam/bad_neighbor_report_test.py
@@ -114,15 +114,14 @@ class Test(unittest.TestCase):
 
         self.initial_connection()
 
-        # Send with a candidate list (should be ignored)
+        # Send with a bad candidate list (should be ignored)
         self.bss_hostapd[0].send_bss_transition(
             self.device.address,
             [(self.bss_hostapd[1].bssid, "8f0000005105060603000000")]
         )
-        # IWD should ignore the list and trigger a full scan since we have not
-        # set any neighbors
-        self.device.wait_for_event("full-roam-scan")
-        self.device.wait_for_event("roaming", timeout=30)
+        # IWD should ignore the list and not try to scan the bad channel,
+        # so we shouldn't get no-roam-candidates before we roam
+        self.device.wait_for_event("roaming", timeout=30, disallow=["no-roam-candidates"])
         self.device.wait_for_event("connected")
 
     def setUp(self):
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 37eb4943..c79afc83 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -297,8 +297,11 @@ class StationDebug(IWDDBusAbstract):
         frequencies = dbus.Array([dbus.UInt16(f) for f in frequencies])
         self._iface.Scan(frequencies)
 
-    def _poll_event(self, event):
+    def _poll_event(self, event, disallow):
         for idx, e in enumerate(self._events):
+            for d in disallow:
+                if d in e:
+                    raise Exception('Event %s found while waiting for %s' % (d, event))
             if event == e[0]:
                 # Consume any older events
                 self._events = self._events[:idx]
@@ -309,8 +312,8 @@ class StationDebug(IWDDBusAbstract):
     def clear_events(self):
         self._events = []
 
-    def wait_for_event(self, event, timeout=10):
-        return ctx.non_block_wait(self._poll_event, timeout, event,
+    def wait_for_event(self, event, timeout=10, disallow=[]):
+        return ctx.non_block_wait(self._poll_event, timeout, event, disallow,
                                     exception=TimeoutError("waiting for event"))
 
     def event_ocurred(self, event):
@@ -886,8 +889,8 @@ class Device(IWDDBusAbstract):
     def debug_scan(self, frequencies):
         self._station_debug.scan(frequencies)
 
-    def wait_for_event(self, event, timeout=10):
-        self._station_debug.wait_for_event(event, timeout)
+    def wait_for_event(self, event, timeout=10, disallow=[]):
+        self._station_debug.wait_for_event(event, timeout, disallow)
 
     def clear_events(self):
         self._station_debug.clear_events()

-- 
2.39.5

