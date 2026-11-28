Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.154.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795859371;
	b=Y/35ZVEmFLyEIvehwjy3vlRzNtoMaLgk46P4loCi7/gYDEn78V1PX0VUIZ+LcpzWz+Tb
	 Sn39Ke2BmKwQHtLnNpZQMHUGiWyflXxoZzASZRAelM194U5HcrSg2DMBZgjfSPAskXG3Z
	 5D4fBrRrJj6iFV35Kci2sCYkW5UX680wqjbjSZqTcIE2UckMMsrBwbSSxyr6A/Msn83tB
	 CR0LJyG1xba0QKWIR5tGJuQeDJqwmYQifYTKfkKFVpzGAt5C7ascLRDRL6L4NHIpbtaOR
	 RgoWYfvG8Bmtf7k6TmtXoVQpDof7g2F6qFsqiYjtMb/k6+o4rfLttk+k84AJx4xMWaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859371;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:X-Google-Original-From:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:Content-Language:
	 Organization:Content-Type:Content-Transfer-Encoding:X-MDID:
	 X-PPE-STACK:X-MDID-O:X-PPE-TRUSTED;
	bh=hB3D3foOeWIIZvD96/fObZNveECEsZikk7JcyL9Dl5E=;
	b=5ISqNS6+KhZWVvlW52211A38vWUG9afSbTID5vsggRyn1C/rgUYSPuqaE6KZh52A4YPo
	 FB8qxmt2qxXNLv9xxgxDKE6GszvtyHOdiRRotYhTTyW0spS5rXJMJ3ba+JRx8hHIeH7LH
	 n96OPFTYHvzj75oW+ErhrckGETQt7QBFGUmGryo2d4B4/JH3hUT71CT+0Fq60IGs/HfVa
	 Y8euv7CdGvaYhY/p5lOeReZX9XXk1Jdquo2SDr+uC6U5o690Lsi2UEU9YvC6JIMDr2wG7
	 xZ1UM7ZK/42OoXEQ11khrj/RyNFEXfyEXU7QwV5WTGvJcnsfqs7EF85IgA2ba9e8oNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=brightsec.com;
	spf=pass smtp.mailfrom=brightsec.com;
	dkim=pass header.d=brightsec.com header.i=@brightsec.com header.a=rsa-sha256 header.s=selector-1756403754 header.b=p3jmjjRA;
	dkim=pass header.d=brightsec.com header.i=@brightsec.com header.a=rsa-sha256 header.s=google header.b=D27w2xHM;
	arc=none smtp.remote-ip=67.231.154.183
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F4606A31F
	for <iwd@lists.linux.dev>; Sat, 28 Nov 2026 09:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63F4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=brightsec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brightsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brightsec.com header.i=@brightsec.com header.a=rsa-sha256 header.s=selector-1756403754 header.b=p3jmjjRA;
	dkim=pass (2048-bit key) header.d=brightsec.com header.i=@brightsec.com header.a=rsa-sha256 header.s=google header.b=D27w2xHM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brightsec.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=selector-1756403754; bh=hB3D3foOeWIIZvD96/fObZNveECEsZikk7JcyL9Dl5E=;
 b=p3jmjjRA+1kN+jd5tfaduyRpjx6Z/84M4tuXZPQZyluBU/PBXbej5BUcI07S/2Jtr4mzWkLCrDWe7mJV/pGlfQrLksZWQqNbrHCGm2JEkyVexcuXXo3EjPmMD1c7THvdj4or7fgqsplkWom8HBnO9Is4tU+Pq55gDrRORo9lltAQbCoG19dBhtnvKQCAqTbHTrlcm5kX7z1Z5quTV0LNhy6ziqbquPJPAi1+6NW1DwfyrGlg4Pmz1OcOBCZ3ym+X47sSzXzzXX/81aco0GOX7Ax2DPuyfC5FvrlMAC6iEYqMxSk9fuyarkRVH4QenOa14Nk82eYTS52D2tjPajGl+g==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 51263240068
	for <iwd@lists.linux.dev>; Sat, 28 Nov 2026 09:49:23 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4b8b27f54f4so10540915e9.2
        for <iwd@lists.linux.dev>; Sat, 28 Nov 2026 01:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brightsec.com; s=google; t=1795859362; x=1796464162; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:organization
         :content-language:cc:to:subject:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hB3D3foOeWIIZvD96/fObZNveECEsZikk7JcyL9Dl5E=;
        b=D27w2xHMeiPu372pcfd0Eazdhx65EIUpMIKr1H1notqrGwUj1XV+H4djruViTUJ4fs
         61q4uTdl7TjrjMamgv5s/XF2sGMGYRIKWUh1Iw3ayqzyOAvYfTIHObh/UR2q4KCprHyE
         mvydK2r+zAwVE4bm1mo+H4bVtP5OrAPs8w96dadd6+0m85oMNJjKTADH1jCB84Hv2/Yf
         mzxmfJBcoiT3R1wgrWB5tIBKghQ+wKAn/ZCWjNK3fREVQS8HLI8mRvWQS5K9VDZdZTvm
         805t3M8BlVkilkF8kg1jFoO4bxQR352NINcbPE4LWA3wyXLtzFlb/WhcTa6/Qu79Ff+F
         JznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795859362; x=1796464162;
        h=content-transfer-encoding:content-type:organization
         :content-language:cc:to:subject:user-agent:mime-version:date
         :message-id:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hB3D3foOeWIIZvD96/fObZNveECEsZikk7JcyL9Dl5E=;
        b=dRsF2JVSMJ1wEucvNv/mTJzpXf5ZPjfc0aEcZ5ideyBGf9bWdNDinzd/rgYRkH5hha
         YZk8ne5veby4iOBAgJg9rxYLP+uw4EC1odL27AHK9OwTTV6AwkX4uR2/mkgdPTy2ugUZ
         rHtdZCtZzww1l0bHdoUO3pEgvLf4VDoniQzMudH/VYjqtmKNHnluux5spgrDYCeX2dOY
         F5DnCbxB9du0jSbiusKtmXQ2dTfPDkTJ3co53Z/DpoHoTszvAyKfoXs3uyNQP01Xtw/8
         hKISilGZtkKU2PjjtMn0c18yLoQq8OIjo6nKPgmnMNWt8ia8b8cr3tT0ymyzLmYNeglU
         CBig==
X-Gm-Message-State: APuU4Z9gw6EPSknyeW9iHF307MEhxHkKj4uhnJ4/cV67g7DoWRhwFRoc
	oydvM0TFvmdw08Mhfstmdkg+5oWxzD18l3fkjjXbgn+xLRCXjOopn+UpfEM082wEXx9tLC0RiMA
	sCim92uoz5EXWGAAClbv3FChPwdeGAxd0alYDIJXedXWnxkCyd0wv/g6pU/ZYYnnlEU0SiDG8sF
	s1Eg9ydRc=
X-Gm-Gg: AZFdTZeQnHMTnXYpmrxGf2GV4V8tS92A0733p6n+Ei1JYIALeGCgN2s2jxd/CToNLqv
	8r/OZKFcZ4CJKa07htSKOnVKbJdEQKzYrzKcRjLpjXU0/v8NbxzT0yf4Sg+gFdT1ndCLmD8pj9w
	BSiy+YuyvUl3awn4heInv8j99+4TnZDDwEWz+qHZ736ZynX8EvZHelNxVjPzh86fCO/D+c7iwDN
	LbnppLO46kBEJs1alELRkgRwXpwDWG77Lz1cB55WwZBdbc8DP2ZsUaPsdGmDMzYTYBBAYWwXfgx
	fy6aQi8XO2n1PKFYD8nkDZA83N/3+IurDA6wDOQoXDgCz3yuqvsAlwSxcFB3i80o7T60eYIbvsO
	HjHDXuGJ65uWEUjZuuYpPa915qjNnS55NOQ1Md4D0seu/8mZv/f4QlGWyYvwIv36oKyb4a6VaOm
	myDTwg7Orpc71ajY2i
X-Received: by 2002:a05:600c:8210:b0:4bb:7ad8:99f2 with SMTP id 5b1f17b1804b1-4bb88785da4mr504586375e9.0.1795859361812;
        Sat, 28 Nov 2026 01:49:21 -0800 (PST)
X-Received: by 2002:a05:600c:8210:b0:4bb:7ad8:99f2 with SMTP id 5b1f17b1804b1-4bb88785da4mr504586165e9.0.1795859361419;
        Sat, 28 Nov 2026 01:49:21 -0800 (PST)
Received: from [10.100.102.24] (46-117-117-5.bb.netvision.net.il. [46.117.117.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm892112655e9.11.2026.11.28.01.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2026 01:49:21 -0800 (PST)
From: Bar Hofesh <bar.hofesh@brightsec.com>
X-Google-Original-From: Bar Hofesh <Bar.Hofesh@brightsec.com>
Message-ID: <f99a535c-ecc6-4364-9b47-2d6083e9102c@brightsec.com>
Date: Sat, 28 Nov 2026 11:49:20 +0200
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Post: <mailto:iwd@lists.linux.dev>
List-Help: <mailto:iwd+help@lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iwd+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 0/3] Fix parsing bugs in scan and P2P code (DoS + memory
 corruption)
To: iwd@lists.linux.dev
Cc: 'Dor Shaer' <dor.shaer@brightsec.com>
Content-Language: en-US
Organization: BrightSec
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1795859364-su1nlIq-4uxi
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1795859364;su1nlIq-4uxi;<bar.hofesh@brightsec.com>;4724a6dac9e71ce549be10d9e0de926e
X-PPE-TRUSTED: V=1;DIR=OUT;

Hi,

Found three bugs in iwd 3.12 during fuzz testing. Two in 
`scan_parse_advertisement_protocol` (src/scan.c) and one in 
`extract_p2p_session_info` (src/p2putil.c).

## 1. Infinite loop in scan_parse_advertisement_protocol (DoS)

The `while (len)` loop in `scan_parse_advertisement_protocol` handles 
`IE_ADVERTISEMENT_VENDOR_SPECIFIC` by doing:

```c
len -= ptr[3];
ptr += ptr[3];
```

If `ptr[3] == 0`, both `len` and `ptr` stay put and the loop spins 
forever. Since iwd is single-threaded (ell event loop), this hangs the 
entire daemon. All WiFi connectivity is lost until the process is killed.

Reachable from unauthenticated beacon/probe response frames. The kernel 
passes raw IEs through nl80211 scan results, so any AP in radio range 
can trigger this during routine scanning.

Suggested fix: reject zero-length vendor-specific tuples and check that 
`ptr[3] <= len` before advancing.

## 2. OOB read in scan_parse_advertisement_protocol

Same function. The loop reads `ptr[1]` at the top of each iteration 
without checking `len >= 2` first. When a non-vendor-specific sub-tuple 
(MIH_SERVICE, etc.) consumes exactly `len` bytes with `len -= 2; ptr += 
2`, the next iteration enters with `len == 1` (unsigned, from the 
original odd-length IE) and reads one byte past the buffer.

Confirmed by ASan on a 5-byte input. DoS only (the read byte is used as 
a switch selector, never stored or echoed).

Suggested fix: add `if (len < 2) return false;` as the loop guard.

## 3. Stack buffer overflow in extract_p2p_session_info (memory corruption)

`extract_p2p_session_info` (src/p2putil.c:517) does:

```c
out->data_len = len;
memcpy(out->data, data, len);
```

The source should be `attr`, not `data`. Every sibling extractor (e.g. 
`extract_p2p_advertisement_id`) reads from `attr`. Here, `data == out` 
(the output struct), so this is a self-overlapping copy. Combined with 
`len` coming from the P2P attribute TLV 16-bit length (passed unclamped 
through `p2p_parse_attrs`), this writes past the 144-byte `out->data` 
array on the stack.

Reachable through `p2p_parse_provision_disc_resp`, which is live. Called 
from `p2p_provision_disc_resp_cb` (src/p2p.c:2918) when a P2P peer sends 
a Provision Discovery Response. An attacker acting as a P2P peer can 
send an oversized Session Info attribute during connection setup.

Suggested fix: change `data` to `attr` and add a bounds check on `len` 
against `sizeof(out->data)`.

---

Found with Bright Security's EVE fuzzer (https://brightsec.com).

Cheers,

-- 





Bright 	
	
Bar Hofesh
CTO
+972-525446813
www.brightsec.com <https://brightsec.com/>| bar@brightsec.com

  * <https://www.facebook.com/BrightAppSec/>
  * <https://www.linkedin.com/company/brightappsec/>
  * <https://twitter.com/BrightAppSec>
  * <https://github.com/NeuraLegion>
  *

