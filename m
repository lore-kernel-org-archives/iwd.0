Received: from out-202.mta1.migadu.com (out-202.mta1.migadu.com [95.215.58.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF920107BE
	for <iwd@lists.linux.dev>; Sun, 15 Oct 2023 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kazlauskas.me header.i=@kazlauskas.me header.b="k20OdzGX"
Date: Sun, 15 Oct 2023 22:40:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kazlauskas.me;
	s=key1; t=1697398840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMWHBCUrsous04Ih8RWcApr7McsF2cqw9VB4k4xhklk=;
	b=k20OdzGXKJ9+fKf2UlvKDCTpFz3M6Fpws0YR26G+SLWf00BbTBo56U7NUvl/7UxL5peTFm
	O93zKgoa1QBpIriV82v9pPTc2JX3Wwad5T9uVFnnofHxl/d7Bhgt4y+2fUpuW7IxBj50Kl
	gNBKuUdUNr2PJsxHK91NGAheUxTgsq8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
To: Denis Kenzior <denkenz@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Message-ID: <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ndgvoicg47cxfhe3"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
X-Migadu-Flow: FLOW_OUT


--ndgvoicg47cxfhe3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hey,

Denis Kenzior wrote:
>It may be we screwed something up with HE since hardware was still pretty 
>rare when the feature was developed.  But we do treat RSSI values below -82 
>as almost unusable.  Perhaps this needs to be tweaked for newer hardware.
>
>If you want to get your hands dirty, it should be fairly easy to 
>modify unit/test-band.c to test what our estimate code does with your 
>specific circumstances.
>
>The local HE capabilities can be found via 'iw phy', looking at what 
>iwd prints at start, or using iwmon.  Similarly, remote capabilities 
>can be sniffed using iwmon and running an iwd scan or 'iw scan 
>trigger'.
>
>Me or James can walk you through all this if needed.

Thanks for offering. I have cracked open the file, and just started playing 
around by adding a new `he_test_data` structure. Alas, I’m really hazy on what 
I ought to be filing into the `capabilities` and `he_capabilities` fields. My 
initial guess is something like this, based on one of the other tests around:

+/* 5GHz, 40MHz, MCS 11, NSS 1 */
+const struct he_test_data he_test_5_40mhz_mcs_5_nss_1 = {
+	.freq = BAND_FREQ_5_GHZ,
+	.rssi = -76,
+	.expected_rate = 275200000ULL,
+	.capabilities = {
+		.he_mcs_set = { HE_MCS_SET(MCS11, 1), MCS_UNSUP },
+		.he_phy_capa = { HE_PHY_CAPA(0x00) },
+		.iftypes = 1 << NETDEV_IFTYPE_STATION,
+	},
+	.he_capabilities = {
+		22, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
+		HE_PHY_CAPA(0x00), MCS_UNSUP, HE_MCS_SET(MCS11, 1)
+	},
+};

This computes a rate of `25800000`, which I’m guessing corresponds to 
25.8Mbps, perhaps? That’s fair I guess, since the only thing I really really 
changed in there compared to the other tests is the `MCS11` (that’s supported 
by AX201) and the `rssi`. There clearly are plenty of other fields that I 
should be filling in here, I feel, if I wanted to accurately represent my 
hardware.

I think I managed to grab the capabilities of both the AP and the client using 
your instructions, but I’m really unclear on how to go from the output from 
`iwmon` to fields in this struct. My best guess right now is to actually run 
`iwd` under a gdb and place some breakpoints in the scanning code to extract 
the capabilities. Would that make sense, or is there a better way to fill in 
these fields?

(As I’m writing this mail, I realize now that I probably want to somehow 
specify NSS=2 for `2x2` MIMO…?)

Another thing that confuses me a great deal is the fact that the scan results 
with my APs don’t actually show any of the HE capabilities, only the HT and 
VHT ones (see attached sample from the `iwmon` output.) I also tried scanning 
an Android hotspot on a reasonably recent phone, and although the set of MCS 
supported were different, the output still contains only HT and VHT 
capabilities. I would love to attach my pcap here, but unfortunately I also 
have no clue how to sanitize it, so I’m going to attach an excerpt from 
`iwmon`’s output for the time being. Is this expected, or could this perhaps 
be at least part of the problem I’m seeing? Is it possible that an AP could 
not advertise HE capabilities at scan time, but for HE to still be used after 
authentication occurs?

Thank you,
S.

--ndgvoicg47cxfhe3
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=x

/* 5GHz, 40MHz, MCS 11, NSS 1 */
const struct he_test_data he_test_5_40mhz_mcs_5_nss_1 = {
	.freq = BAND_FREQ_5_GHZ,
	.rssi = -76,
	.expected_rate = 275200000ULL,
	.capabilities = {
		.he_mcs_set = { HE_MCS_SET(MCS11, 1), MCS_UNSUP },
		.he_phy_capa = { HE_PHY_CAPA(0x00) },
		.iftypes = 1 << NETDEV_IFTYPE_STATION,
	},
	.he_capabilities = {
		22, IE_TYPE_HE_CAPABILITIES - 256, HE_MAC_CAPA,
		HE_PHY_CAPA(0x00), MCS_UNSUP, HE_MCS_SET(MCS11, 1)
	},
};

--ndgvoicg47cxfhe3--
