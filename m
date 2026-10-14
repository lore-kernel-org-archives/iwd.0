Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE240401A18
	for <iwd@lists.linux.dev>; Wed, 14 Oct 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995418; cv=none; b=Du/cJGllZuOShxQykhTK0H91OGxasW/1T6uBJ/8PeQxWOsk+bcPAOEpW/B9Q4Gx2bZrJ60ZZdmnDLiFEhqzzrlpazOsyV7Eq5bbGkOt1izObqH9uFQRmJgFtxtD2/YDtOG6tec8coFQff6hJskNFUcrSkuAkWmVjSbG5aUgRlCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995418; c=relaxed/simple;
	bh=nbKlJcWVD/6lkGmGzm/lxxdKsmGdcpwJ/9FNaoY9L+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rb8BFW/4wFmfwKTEbBme7DW/DbnvvR3azvINNsO404OIsEMzGajM+2qcCfAU6cHmJMtinrHMqKS4x6L+OVz9kvp+JnPwPgrq4Ha7DEnzWsALRGzdBS98PiynDRpQbO/+Ia5DDjAe+ptKm+2AcJnFxjyh1jEH763XQqhz1BPAgYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=FI2AKhjg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="FI2AKhjg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a01933b584so38160925e9.0
        for <iwd@lists.linux.dev>; Wed, 14 Oct 2026 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1791995412; x=1792600212; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GF5vpBK2WMbTJXFTO4I1aPmMc39E49npYNfNYPMeizQ=;
        b=FI2AKhjgD63Uz8zfne4ndMK9puIBsLUjXCg5F99a0nlB0Tbmz1Iz+CkJwNDl/A01/K
         LNzMZ5ZVd5o88V5R86jhs8dGxnBuDbCRp9qdpJ4HlbU3n5R5Y46savdgvRGXbVT8umOZ
         M4won+MuA9PFXOPgjwpKsYEswFV83T747shsxOoy35VuXEmy9sBa/e3B4No9eQLHO7IQ
         9cqU+H1vbB5f9DqWVGt7KHQhRn14vjrAiV9XclZ/+dgbvljo+PPmrIBGxhfnTsjrBTru
         6+RHzphKjktn8Zz2IIm835myElsHGaoeRU+Z6afkv8cOwsVmMPfPd/5fjGMG5keNIlKp
         +5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995412; x=1792600212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GF5vpBK2WMbTJXFTO4I1aPmMc39E49npYNfNYPMeizQ=;
        b=hjcxppVKxopHk9sLvLmd7NkFHpuDm5SyxU6jljGyl392CBTKkEhkKCpchRxn7R0qjQ
         z4o4Mxrm+6mQZKeN6CZGiirUiI76G1DmrmeuaHekXIdd+l12zwjvhsrbZlPPDbqWVa8V
         24U2ZiZ2gggbbomnYzPqEWIw+N4xsXm5KZL2NyzAXWq0+jKiyYN8eUtdBvGqQVCfoFG4
         +M82AzZByJCAVlcbH/vmWf7bP2Z4l4Xv50HNemOoPnf1a2tjVSWyE1cGQleYXbNWK4wg
         T7HPKmBtrc9a2IGVlYWFBZqKCSCIGEKWeA2M7I9LA2vuwqiCuF70iEAkaeQrTqIM6Dw6
         D+iw==
X-Gm-Message-State: AFq9FYKzSZgyjFRn/t7k6pFKW2XgNZPr2TLFPBKM2J+9s6zUU3vr0JRc
	tP64hrSw4beZolV5obtS8esz9xOgIapXBxoCG670+s5Fz3c4vJEtDZiJvY1O2pAm+Htbvzn0Dfd
	2apifNGFN8w==
X-Gm-Gg: AYBFou0yRFvFA8/j7DcJWJSaS19idTJatAMQuhZlo/++5kRR89+g62aZM0e1Kxhc/3L
	yqvgKIokDQgErKTMYmOKCL7FpdlR9lPtdLQ+QXrtmxfS0MLXRmh+iZKhT07d0uvmrxkLcrqSnuS
	oEPbpXg0fUY0re1iPAij6D+87zcQQnULlA/mBfheuGORbC7GFvkkjnmBpYADAz6OQKX/x44LtY5
	FyCRcX4QHR726/cse4wVs3aOg0pMmjfX7gcubOMBnn84yB4OZZMNCz3DUjiQx6CYE+HrsMbuUpi
	0e5ypmN4cwcMw6NkctNYvPIUXRh3Mj5db8C1hiQocETxsEtO3eAFngoyCakRiYknnyqCjp/HMG0
	kfSMSeqjaEZl++WDNcyzGy1AJNGzoK6xume4H5NOEP2gIsEdKke4FHZjiqr0gws4hsNlLSFEhor
	eXuZ3/iR5u/6N2JBB1UiaA1pDkklW5c0+YTQUXXWqWRlMgyUIj3AcmdP+ICHB4TLydfV4cysO7r
	LcSjmoLeTKGyg==
X-Received: by 2002:a05:600c:a0d:b0:4a1:b187:1314 with SMTP id 5b1f17b1804b1-4a1b1871350mr74747955e9.7.1791995411722;
        Wed, 14 Oct 2026 09:30:11 -0700 (PDT)
Received: from debian-hp-1.fritz.box ([212.233.51.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967affsm11641747f8f.1.2026.10.14.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:30:11 -0700 (PDT)
From: =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
To: iwd@lists.linux.dev
Cc: =?UTF-8?q?Rapha=C3=ABl=20M=C3=A9lotte?= <raphael.melotte@mind.be>
Subject: [PATCH] hwsim: tolerate a third wiphy address (NAN)
Date: Wed, 14 Oct 2026 18:30:00 +0200
Message-ID: <20261014163000.692565-1-raphael.melotte@mind.be>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_addresses() reads the per-radio addresses from
/sys/class/ieee80211/<phy>/addresses and fails with "too many
addresses listed in sysfs - only 2 supported" whenever a radio
exposed more than two.

Since kernel commit a37a6f54439b ("wifi: mac80211_hwsim: Add
simulation support for NAN device", first in v6.18) every
mac80211_hwsim radio sets wiphy->n_addresses = 3, the third address
being for the NAN device. As a result parse_addresses() rejects every
radio, CreateRadio call fails with net.connman.hwsim.Failed, and
the hwsim-based autotest suite cannot run.

The hwsim tool only uses the first two addresses, so read those and
stop at the third instead of failing. At least two addresses are still
required.
---
 tools/hwsim.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index b7d637ca..45c57d3f 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -593,11 +593,9 @@ static bool parse_addresses(const uint8_t *buf, size_t len,
 		memcpy(addr, buf + start_pos, pos - start_pos);
 		addr[pos - start_pos] = '\0';
 
-		if (addr_idx >= 2) {
-			l_error("Hwsim wiphy %s has too many addresses listed "
-				" in sysfs - only 2 supported", rec->name);
-			return false;
-		}
+		/* Only the first two addresses are used, ignore others (e.g. NAN) */
+		if (addr_idx >= 2)
+			break;
 
 		if (!util_string_to_address(addr, rec->addrs[addr_idx])) {
 			l_error("Can't parse hwsim wiphy %s address from sysfs",
-- 
2.54.0

