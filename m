Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CF286D44
	for <iwd@lists.linux.dev>; Mon, 22 Sep 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576212; cv=none; b=Ef1popwnPpKCZybi97FY/eUDnLboPVr1CCvF04Gq6MmVKxVaizEg3nXWBf9ZRrz8AeGvbd7VrDfruBfZLOzqXQdtVmmznjElLcpYZDTI2fN/yXQLDWj3A0RRtZrb3AXVkHgk2+3G7PfI4sGBnYQq7GJnmbi9M647nLCQE7D4zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576212; c=relaxed/simple;
	bh=rW1yyoPh78u2iQXpTwXa4hkLH8GeWgtkusdPHevaWaA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MuoUWLQ8+HvXaeadcwbWy+/c+3TIUAaLXzKAG86yAET7YCs57Lyziow+kpNonIpYgEYwedkORHwGI99hLcueBqEJ94QhIT9fiY7EaOsQK1sjQ+22lolRVtf+5EVE9Og+Ow9vnFP1pzFCLJITLbFEJmp3q81YKAzml+nSi4GaINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkWBk2pt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkWBk2pt"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b2e66a300cbso198465266b.3
        for <iwd@lists.linux.dev>; Mon, 22 Sep 2025 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758576206; x=1759181006; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aAKYpKQvUFAF+ZhgWY2+Oe+jWjCIM0E1jfJY4xD5HuU=;
        b=QkWBk2ptICuTBVN37uPwytdHZgIa4SqJEeROrry7tfsGoZQziDYfDEQLu6WvLXqItq
         fw61BBZj21sFHX9W/roIrEx/V/nEwdd1pbOZtD+8+uIQHsN7VJOeHbnOlxaesDt1/Rj0
         9A3OfvU/Ndjhi/VBtIW4uO7CWqj5vkIylY3OfeJnVyBqLIYyanICeaOIYHimtl/mk/D1
         X0fmpG0Ff2iaIVWPdnDVMfT1S8TE6J9wMmtRjKSbPfPu/uDa8hvgBb4+mJgFJZykmE6D
         MAtEZLcjldXcklPsCBQJzjCul/VIX3JQzRxNVNwijh4yWnx1sJk251wWQKsQMT/Xyv8u
         ljBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758576206; x=1759181006;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAKYpKQvUFAF+ZhgWY2+Oe+jWjCIM0E1jfJY4xD5HuU=;
        b=Qk7Vfy6iXaD7GwjFTGX1VPRyHz/obTGH7vG0r15P8DttvQ8A/p1EfYlP7p6YWfqwYA
         EnUfgem5WemmCENqOL3trd0gQVpHBjXgbueVn/ai6oUX1T8/0XKemAVrPH1pPpPClbVK
         o1sprv2reAPZmdkcFbc7yut1idIa7PVP906Kv9HquyYqguA+q3UMrihx1hG9caYnfPCg
         hzzWkUFFQpr3RDuyX2UGPcD+S8eSJZGNBCVNy2JrI3wsTAPC2T//jYNGYrYeV3SEnZJD
         3YefhG+fxO36IvMgwsjUGL/BGiDWTJ/cJ9LWmLbzMqvfBfiJsYDKLuRgyS7MoaRdV6yc
         gEAg==
X-Gm-Message-State: AOJu0Yw8BL1hyVQ66CHCICo7NSBDglrZ+y9qdW7b8eIMFuKRjqVxXK7d
	8HYL2NpI+IvSSGJ1x6XJ4PDHIv5DX2+odYSYMKDmzZV/kZAp9VidZO3E+e/mikZle6xRjAriN/Q
	8PJoBCmch9hL9L+9lRKrf42BdFdFn+x7flUdu3Uo=
X-Gm-Gg: ASbGncsipmSqC4g2RSkgoVAb66hVxmMrKVGr23QHPTzw4bCowQEniSZN80LA7eYZvAT
	fQMC1W1Q5NHqBd3+GaybFD2vlowPe5WXDt3HKXmSU4bRJb8XNeZM8z7Ta29ZJlIU346NsRHSPqC
	dow+6mSAjwgjH3DSzuHEKBGv1zIE8PXbi4jP7oPigRhkDS9e45chQIVIGySrlyY+/cnyQVNzOVm
	xurOm7hJVctjJWlnkFDFSuvi+0wOZXJOWTak1I66g==
X-Google-Smtp-Source: AGHT+IEsZlR5K+3JQ97+8RB0mbWUSEDYw4pW2mGSkRdi3x6XDXVdkIYWjiLj5L73LqWZVVQnRhOu5orrllVlBHsCKAo=
X-Received: by 2002:a17:907:2689:b0:b29:e717:f0af with SMTP id
 a640c23a62f3a-b3027d3fa99mr8892166b.18.1758576206400; Mon, 22 Sep 2025
 14:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: amit kumar <amit60700@gmail.com>
Date: Tue, 23 Sep 2025 02:53:19 +0530
X-Gm-Features: AS18NWA5npZRiUgus-T9wAPuCmBZQRl-OSGhSjafwQf3iyd-F_6wWnPwlWj69TQ
Message-ID: <CAJNKUtceMPq+Yijythto5YW6a3k3B9oxApve4Pss=g2zAdEKhg@mail.gmail.com>
Subject: Inquiry: Is WPA3-FT Roaming Supported in iwd ver3.9
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear iwd maintainers and community,

I=E2=80=99m currently working with iwd version 3.9 and have been evaluating
Fast Transition (FT) behavior across different security
configurations with standard Cisco AP (It supports FT roaming).

In my testing:

1> With "WPA2-FT only" security configuration, connection and roaming
works flawlessly =E2=80=94 the device connects and roams as expected.
2> WPA3-SAE also connects without an issue.
3> However, when the AP is configured with "WPA3-FT only" (AKM suite
00-0F-AC:9), iwd fails to connect, logging:
        iwd[440]: autoconnect: No suitable BSSes found.
4> With the same AP's config, wpa_supplicant is able to connect and roam.

Upon reviewing the source code, I noticed that the AKM suite for FT
over SAE (IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256) is not included in the
logic that identifies WPA3-Personal networks. After adding the
following patch to ie.c, iwd successfully connects to the WPA3-FT AP:

----

diff --git a/src/ie.c b/src/ie.c
--- a/src/ie.c
+++ b/src/ie.c
@@ -1338,7 +1338,8 @@ bool ie_rsne_is_wpa3_personal(const struct
ie_rsn_info *info)
         * 3. an AP should enable AKM suite selector: 00-0F-AC:6
         * 5. an AP shall set MFPC to 1, MFPR to 0
         */
-       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256))
+       if (!(info->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) &&
+           !(info->akm_suites & IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256))
                return false;

        if (!info->mfpc)

----

My query:
Does iwd officially support WPA3-FT roaming? If not, is there a
specific reason this AKM suite is excluded =E2=80=94 such as spec maturity,
roaming logic limitations, or security concerns?

I=E2=80=99d appreciate any insights into the roadmap or design consideratio=
ns
around WPA3-FT support. Happy to share logs or test results if
helpful.

Best regards,
[Amit Kumar]
