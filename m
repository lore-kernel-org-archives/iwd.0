Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBDAEAFD
	for <iwd@lists.linux.dev>; Sat, 21 Oct 2023 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kazlauskas.me header.i=@kazlauskas.me header.b="gN3ri4c6"
Date: Sun, 22 Oct 2023 02:23:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kazlauskas.me;
	s=key1; t=1697930615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OeAjWMi+0qYzJgXKodTow+OtxGMIREkA/UL3gRJ9BO0=;
	b=gN3ri4c61wSMe+ejoSD6OSpIkkX9bADZqOlLzsxqoBd/0W8rvvYq5FaB0fTIgwCsVz+ARa
	LItzcekR2hz60HzIvnM632UT2wdouEsLT+D1Moo4eJIhBN03wPUqCihR54EV/k1LLSA+Ei
	QzOUlhcyheoTXrsVxA4PS3O/GLBmF0U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev, Denis Kenzior <denkenz@gmail.com>
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Message-ID: <sebayhpora5e5ispmp5nnjesihoewc74ohygd3orxp7k22ky4c@tt225sdpjrxm>
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
 <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
 <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jbhmlqtn53gjecim"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
X-Migadu-Flow: FLOW_OUT


--jbhmlqtn53gjecim
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hey,

I finally got around to figuring out the test specifications (I think.) At least 
the test results I’m seeing are the same as the output from `iwd -d`.

See the attached patch (feel free to merge it, or not to merge it – entirely up 
to you.)

72Mbps appears to be coming from the table for 80MHz rates (NSS=2 so 36MHz in 
the table itself), but this *should* be a 40MHz ordeal. My APs are set up for 
40MHz 5GHz channels and 160MHz 6GHz channels, but it seems like it might still 
be sending capabilities that include 80MHz support…? Weird.

[1]: https://semfionetworks.com/blog/mcs-table-updated-with-80211ax-data-rates/

Anyhow, besides the 80MHz weirdness, this all seems to ultimately come down to 
the `ht_vht_he_base_rssi` table (as you both have pointed out in the very 
beginning!) After the `width_adjust` in `band_he_rate` is applied, -76dBm is the 
bare minimum for it to pick out even the lowest 36MHz rate from the 80MHz table. 

Meanwhile in practice I’m getting MCS anywhere from 4 to 10 (seems to be fairly 
random regardless of the signal strength, which varies between -72dBm and -79dBm 
this particular evening.) The only caveat is that for very high MCS values (8, 
9, 10), NSS appears to drop down to 1 (thus making them roughly equivalent to 
MCS 4-to-5).

I’m not sure if this stellar MCS behaviour is Ubiquiti’s doing something fancy, 
or if its a result of those aforementioned thick walls, which *also* happen to 
block out any interference from the neighbours as well (making my APs literally 
the only transmitter in the 5GHz band devices bother noticing…) 

I have no clue if there’s anything actionable here, but I’m happy to help with 
testing the observed behaviour at various signal strengths if coming up with a 
better `ht_vht_he_base_rssi` table is… on the table :)

Have a great weekend,
S.

Simonas Kazlauskas wrote:
>James,
>
>Thank you for implementing the display of HE capabilities in `iwmon` – 
>these do indeed show up in my scans now, false alert there.
>
>>HE Capabilities: len 34
>>    HE supported channel width set: bit  1: 40MHz/80MHz supported (5GHz/6GHz)
>>        Rx HE-MCS Map <= 80MHz 1 Streams: MCS 0-11 supported
>>        Rx HE-MCS Map <= 80MHz 2 Streams: MCS 0-11 supported
>>        Rx HE-MCS Map <= 80MHz 3 Streams: MCS 0-11 supported
>>        Rx HE-MCS Map <= 80MHz 4 Streams: MCS 0-11 supported
>>        Tx HE-MCS Map <= 80MHz 1 Streams: MCS 0-11 supported
>>        Tx HE-MCS Map <= 80MHz 2 Streams: MCS 0-11 supported
>>        Tx HE-MCS Map <= 80MHz 3 Streams: MCS 0-11 supported
>>        Tx HE-MCS Map <= 80MHz 4 Streams: MCS 0-11 supported
>>    0d 01 08 9a 40 10 04 60 48 88 1f 43 81 1c 11 08  ....@..`H..C....
>>    00 aa ff aa ff 7b 1c c7 71 1c c7 71 1c c7 71 1c  .....{..q..q..q.
>>    c7 71                                            .q
>
>I’ve sent you and Denis both the pcap of the scan. I, unforunately, 
>don’t think I’ll be able to hack on the test and/or data rate 
>investigation much further before the weekend, but I’m happy to test 
>out patches and such at any time.
>
>Thanks,
>S.

--jbhmlqtn53gjecim
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-test-band-HE-band-test-with-real-world-capabilities.patch"
Content-Transfer-Encoding: 8bit

From 6961629e93d9e74f5760c5be00393459ad55c0b5 Mon Sep 17 00:00:00 2001
From: Simonas Kazlauskas <git@kazlauskas.me>
Date: Sun, 22 Oct 2023 00:46:38 +0300
Subject: [PATCH] test-band: HE band test with real-world capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I've been observing that the rate estimations in the real world usage
end up being quite a bit different from the rates that end up being used
after the association. In this commit I’m adding a test case with the
capabilities from two physical devices, if only to demonstrate the
how the rate estimation behaves in such circumstances.
---
 unit/test-band.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/unit/test-band.c b/unit/test-band.c
index e27531f7..fec09e61 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -294,7 +294,7 @@ struct he_test_data {
 	/* Own capabilities */
 	struct band_he_capabilities capabilities;
 	/* Peer HE Capabilities IE */
-	uint8_t he_capabilities[31];
+	uint8_t he_capabilities[36];
 
 };
 
@@ -366,6 +366,31 @@ const struct he_test_data he_test_5_20mhz_mcs_7_nss_1 = {
 	},
 };
 
+/* 5GHz, 40MHz With data from a real-world Unifi’s U6 Enterprise AP and a client
+ * with the Intel AX201 card.
+ */
+const struct he_test_data he_test_5_40mhz_unifi_ap_and_ax201 = {
+	.freq = BAND_FREQ_5_GHZ,
+	.rssi = -76,
+	// In practice seems to be more like 275_200_000ULL instead...
+	.expected_rate = 72000000ULL,
+	.capabilities = {
+		.he_mcs_set = {
+			HE_MCS_SET(MCS11, 2), HE_MCS_SET(MCS11, 1), MCS_UNSUP
+		},
+		.he_phy_capa = {
+			0x0e, 0x3f, 0x0e, 0x09, 0xfd, 0x09, 0x8c, 0x16, 0x0f, 0xf0, 0x01
+		},
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		0x22, IE_TYPE_HE_CAPABILITIES - 256,
+		0x0d, 0x01, 0x08, 0x9a, 0x40, 0x10, 0x04, 0x60, 0x48, 0x88, 0x1f, 0x43,
+		0x81, 0x1c, 0x11, 0x08, 0x00, 0xaa, 0xff, 0xaa, 0xff, 0x7b, 0x1c, 0xc7,
+		0x71, 0x1c, 0xc7, 0x71, 0x1c, 0xc7, 0x71, 0x1c, 0xc7, 0x71,
+	},
+};
+
 /* 5GHz, 80MHz, MCS 7, NSS 1 */
 const struct he_test_data he_test_5_80mhz_mcs_7_nss_1 = {
 	.freq = BAND_FREQ_5_GHZ,
@@ -698,6 +723,8 @@ int main(int argc, char *argv[])
 					&he_all_mcs_unsupported);
 	l_test_add("/band/HE/test/low RSSI", band_test_he,
 					&he_test_5_low_rssi);
+	l_test_add("/band/HE/test/5GHz/40MHz/Unifi+AX201", band_test_he,
+					&he_test_5_40mhz_unifi_ap_and_ax201);
 
 	l_test_add("/band/oci2freq 1", test_oci2freq, &oci2freq_data_1);
 	l_test_add("/band/oci2freq 2", test_oci2freq, &oci2freq_data_2);
-- 
2.41.0


--jbhmlqtn53gjecim--
