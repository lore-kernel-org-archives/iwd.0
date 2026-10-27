Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.143.172.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096873;
	b=iUp1v8rq+MTGtyS5rgyiEZSPk/4yCgU1DcaIvyUwRFzI5L7MQ3cPZpg74g+69I5ZBgMD
	 +RRPic6YeZxu5snMr1glwUN8D1TQOicwrpoZAZReWoC/ik+5pwJZaY121qLAjkZ3fuYM4
	 ndd+ZZyy0/uXgC45Yl33gHZMy4J6w34dirEAUpDLZZ+0T4vy4p24IWsUHS0fjthtwNcQX
	 jT1FqZ5vcoKBOKgunHyxOGlACaA9qYAL/7w/L7gt6qiUWSRc0Qe3L2E20X/pAKQwfcN6a
	 LlIK19NB/mtGtcCBqEfHJZvyt1deKVClXtTH2MUaeNCKprkRw37OHuyf2b69S5lcnAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096873;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Bar:X-Rspamd-Report:X-Rspamd-Score:
	 DKIM-Signature;
	bh=sWhDcMhHaMg66KUR+NsXWPZjnzGmZxWSIi3kBql4ZEA=;
	b=d721Ako1QNStH7W1KPWOF2FRhvPj1haNk9kfFmnDwPPU1WH57BKCMdZmPBIvdCgqyxZy
	 98hnOhWxqOIBbGt3R6Qs8y3gRv1XeyO0DSHAIFZw5NNPy++d9pHw+ZDkJ0uPFthostVE4
	 8pm8rwSd89whMmfvEZsdcAwv+at4EfovJZSr+cO+l0N34TZfcnAP5od8P3Czur+0ppSDh
	 uTPGrmvTjrN8P8YBM2lFiQitmIZr5U0iPz+ftPiv4FLSx0lvWKeWWlNmxb0KyHB3G1Uqz
	 y8YMcBcjF9uA5QmqvwRVnsnL6MiOSabcHF9a+hQJLBVX547DcN+NrKmW8F9k4ab7V6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jhbruhn.de;
	spf=pass smtp.mailfrom=jhbruhn.de;
	dkim=pass header.d=jhbruhn.de header.i=@jhbruhn.de header.a=rsa-sha256 header.s=uberspace header.b=CzNr4tLa;
	arc=none smtp.remote-ip=95.143.172.20
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF9606A31A
	for <iwd@lists.linux.dev>; Tue, 27 Oct 2026 10:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32FF9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jhbruhn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jhbruhn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=jhbruhn.de header.i=@jhbruhn.de header.a=rsa-sha256 header.s=uberspace header.b=CzNr4tLa
Received: from boethin.uberspace.de (boethin.uberspace.de [185.26.156.96])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id ECEBE615BE
	for <iwd@lists.linux.dev>; Tue, 27 Oct 2026 11:27:44 +0100 (CET)
Received: (qmail 14578 invoked by uid 990); 27 Oct 2026 10:27:44 -0000
Authentication-Results: boethin.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by boethin.uberspace.de (Haraka/3.1.1) with ESMTPSA; Tue, 27 Oct 2026 11:27:44 +0100
From: Jan-Henrik Bruhn <git@jhbruhn.de>
To: iwd@lists.linux.dev
Cc: Jan-Henrik Bruhn <kernel@jhbruhn.de>
Subject: [PATCH 2/2] eapol: use vendor quirk to relax PMKID check
Date: Tue, 27 Oct 2026 11:27:35 +0100
Message-ID: <20261027102735.140381-2-git@jhbruhn.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027102735.140381-1-git@jhbruhn.de>
References: <20261027102735.140381-1-git@jhbruhn.de>
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Post: <mailto:iwd@lists.linux.dev>
List-Help: <mailto:iwd+help@lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iwd+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.087496) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.687496
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=jhbruhn.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=7y/p3/JqfmBQxWmfPuQu84CNOjPyFKXcb0sUZj9ROQ8=;
	b=CzNr4tLauIcYm415AjzN0FrYpsXfePtYpcI8WcgBOuwq+Ht7uBiZWFisahgdbH7csocEdnOBF3
	HIHuIfjUO7QIzd+wMlwjmZmVmQtqN5Y8L5Ow5AmBzJmI/B0OD3HjlyrgKQJWBddzV18pbUl4fPRQ
	8s0SEgmMfHujXn7eSpOBl59iWJQkESsQutV+Hn6OgB07KsKHnjq9XSdYqmevuop5jk3WsevIJP6/
	IOXxtttj8GVv7xl9SFeRsbATXVoCChd2j9UUcipIoQsowpS5ndqpAsHds44XotArZUxWplwyHcd3
	89nHqqjy7gtYjdypCjCDpk1F5D37ezIIydDqDJCV9KDAQxwVBUjBcfB45kHOBQmNS66tp3RwrWsD
	IH7CVMClDSlfL9ELFtQYtAfOSmbgaa7/ml9oYaYq+HFlh032b3Vb1qvH/SrCNU5H//xo077cEyCX
	CfU0NWqvI0y/QoO0CkFFZk/u5QZQr+JbUfRsqC3p2lTUznlI8G8cTYsRmhlTaoVaAcw+spd86CFV
	H5jJgXoHrwQmNpuA87W4rrcl0lfG8fqUav3EVjn+DTbS295o/ZYpjEogg3zfKOkdkQ4fr4rM75cj
	/FsZK7BlVR3SxtXTHMQmZgz+dqK/pixUE9ZxxTP5XEOatqd87lV0aXcI6h8sAcTQH5Na0qhz80E5
	s=

From: Jan-Henrik Bruhn <kernel@jhbruhn.de>

Extreme Networks APs running WiNG include a PMKID in message 1/4 of
the FT-8021X handshake which IWD cannot validate. It does not match
the PMKID derived from either half of the MSK (SHA1 or SHA256), nor
PMKR0Name/PMKR1Name, and changes on every attempt. IWD treats this
as a PMKSA mismatch and restarts EAP, which only results in another
mismatch until the AP deauthenticates the station.

If EAP was just completed the PMK is fresh, so restarting EAP cannot
help. The PMKID in 1/4 is also not covered by a MIC, whereas the
PMKR1Name in 3/4 is, and is already validated. For APs with the
pmkid_mismatch quirk, continue the handshake in this case.

---
Notes:

Seen with Extreme Networks APs (BSSID OUI 00:dc:b2, vendor IE OUI
00:a0:f8 type 5), FT-8021X and PEAPv0/MSCHAPv2 with Crypto-Binding.
wpa_supplicant connects fine.

Without this patch (iwd 3.12), every attempt looks like this:

  EAP completed with eapSuccess
  eapol_handle_ptk_1_of_4() ifindex=9
  handshake_state_pmkid_matches() PMKID did not match, trying SHA1 derivation
  eapol_handle_ptk_1_of_4() Authenticator sent a PMKID that didn't match
  PEAP: tls_tx_handshake:1244 Sending a TLS_CLIENT_HELLO of 172 bytes
  ...
  Received Deauthentication event, reason: 32770, from_ap: true

A debug build logged the received PMKIDs (fe890a12..., b7936fa1...,
d3531a44...). With this patch 3/4 is accepted and the connection
completes.

With FT-8021X removed from AKM selection (same APs, no patch) there
is no PMKID mismatch and 802.1X connects fine, so this is specific to
the FT-8021X implementation on these APs.

 src/eapol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 372549c..d802adc 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1256,14 +1256,19 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 			goto error_unspecified;
 	} else if (pmkid) {
 		if (!handshake_state_pmkid_matches(sm->handshake, pmkid)) {
+			bool ignore = sm->eap_exchanged &&
+				sm->handshake->vendor_quirks.pmkid_mismatch;
+
 			l_debug("Authenticator sent a PMKID that didn't match");
 
 			/*
 			 * If the AP has a different PMKSA from ours and we
 			 * have means to create a new PMKSA through EAP then
-			 * try that, otherwise give up.
+			 * try that, otherwise give up.  Some APs send a PMKID
+			 * we can't derive even after a fresh EAP exchange, in
+			 * which case restarting EAP won't help.
 			 */
-			if (sm->eap) {
+			if (sm->eap && !ignore) {
 				__send_eapol_start(sm, unencrypted);
 				return;
 			}
-- 
2.43.0

