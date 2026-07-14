Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C4339B41
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035634; cv=none; b=FITHpU9ejxMIasu+fYlEGLCXaOIycE63YfXY64Eg7QKYk1C7yLTMLSUAop0X1ZzncnJYo91fjz+4/GzUqvxlicvBcTjPxIJLahDNcu+rRaRfINauJinMPMDbuTL1h1hiIJXaSySemv7LsOzFRvwiSQ5+fDBW3R5l1KbWvb9wnrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035634; c=relaxed/simple;
	bh=Do0Cw45EJ8pQuk9GYRe9G6s0cXxasSx7M0v5AJ9yC/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NJ9tt1B+3USWGin2bNBlGO+urUpK+xWNuRLENkRy15H4mCws6ItUW5FbLxIihmumjLM+q4A2Fq5XPU97UkcqV1w0cURgym01ki+TFw0hM1XmKb6jtc5LFG4zRAj0jQjByOJ7jEP8Pi+TcN9sCGLM6658/Ev1p9gjJ3T6Fbewpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTFpDFxa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTFpDFxa"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8486672f03cso3891748b3a.0
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035632; x=1784640432; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxxJLb9RcHbHYOJ4/9fLKAxiabkWDLD3hpBRhYjAuWE=;
        b=jTFpDFxasWxHckRvcMCAtBEZ7q+fZm5F5c00RUhNf5P94uq87DCOTKE76cOxQ/SrQ0
         FX3ritVxEJmDXlx7jXvYOYnP3ojGXWbScuZqiUrFXzUF2O0MwZNdJ7FUj727awE6EpN+
         nCNdn0nkhWV3Ey9GbLWo7A0IX1D9NeEGP/YnneCxO/5TugBpvTX5dLrpiuwMGad8g+J1
         9D05xsXGHhplRaLQcAu070W1cNzeMiZq/Vjetn3xCCJK3xYSnpnJ1sZ4M/fmaOISTdcj
         CSz9MZwR4owGgYFq+EYp2QqNBiKOU8I3TUPY3Rri0pZ0kx+zx9jkLfwB/4Jhvqo4ryre
         Tp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035632; x=1784640432;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxxJLb9RcHbHYOJ4/9fLKAxiabkWDLD3hpBRhYjAuWE=;
        b=VgWgX3rSH/aNx4ue4Z+1LxnhwVN8nWGkSf/AXvi8kPsH7ULNPCREikdT8K26bkzyUR
         +NWHUMiuGrX5xgAjdypfYZ9exl4TYRD0clRasCBH07z3Smc3jefLjGxRzyz4wRqDq8rf
         EWAYoq1Kiy9FEC2NCDCTt0et0uc6zksld3nxCYDJzfKhr7nHsZFvqVnbi+GxYGluKTt3
         jMh+wjTU1rZgopm8v91+gmw5NEz6hvLo6a8m+wq6Ym6DJq3EHuQhFBI1Q20oPYLVfvPt
         cgf2l4j9s3tSvDK6MofbBM92VMRrd2uHFLWioq4M7lU3G9345+csMaKXuXnsnFO9XUbR
         4sTA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0DCpK+SAoqE5nEJgM/7PyMdPaIMWcbUfwDSxJsXttaEWgwqtoVQapY1Ua+36Jy9jI+4Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YxGW0k8SEZsP9FGDF91U7ilY5EzvPpTDH/h3AqKnk3UaP0/XtOR
	T5f3EPGrtjl/Af2a6aZ7dA/D7/eVQbqk+05/wULc+759ME4rSnkkzmpGRjMmEQ==
X-Gm-Gg: AfdE7ckJSJjh2tc3eij5/Z1bxJu3i8gMqCLxqDXEg+JurPkkIMLkLAf5Oq+2SUPTODu
	pE6Hv47XBbdFQhvOR538dGmreS6KeqZAo9XFU0al8T6WP21q98PQKE53bfQnNiTIM1qmSSuIvTJ
	oZoU8L2Jz0GtsjMUxvg3Bga2H8VX4d7nPyMtT9q3v4nMGqoIjR57KH3Ciue7dHH/eFrrydUsNhR
	F5VjGDXLjRL0PMpBpBq2Dhh5MueOlm5qIg7++8r+i2hxlCeSKpIm9h/mCcOTgjTXEg61VDoH7LX
	3mY/VJv1gmtmir4tIyXcYRRity5l4048TTqBJlksHJbeDyKYfvH5LoVW6f+GGUx3smNAtkho6FI
	UYUNEtcD8y33GzWXggjlLY7Dd2BUQQ+nbWKlzeeP6xXlIAXeh5ckGA8uetCR/AkxXQFKxgNugKM
	7YU43RW8VinVW4IE+gK0ZQhZ8crBpbYJCaZ4LUF6lW75bb3UPgdDB46E23Xux0y+Gnvj+Gs+Njh
	3hH3fZ9jNRHGrBu/mOVYK8hX7w=
X-Received: by 2002:a05:6a00:c210:b0:84a:2c46:3fe2 with SMTP id d2e1a72fcca58-84a2c464352mr5975390b3a.48.1784035632300;
        Tue, 14 Jul 2026 06:27:12 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f241d60sm1628416b3a.11.2026.07.14.06.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 06:27:11 -0700 (PDT)
Message-ID: <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com>
Date: Tue, 14 Jul 2026 06:27:10 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] dbus: expose per-BSS security capabilities
To: =?UTF-8?B?0JDQu9C10LrRgdC10Lk=?= <aleksman4o@gmail.com>,
 iwd@lists.linux.dev
References: <CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC+RaJKsKz0sUivGAQHXA@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC+RaJKsKz0sUivGAQHXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 7/11/26 1:07 PM, Алексей wrote:
> Hi,
>
> NetworkManager cannot currently distinguish WPA2-Personal, WPA3-Personal,
> and WPA2/WPA3 transition networks when using its iwd backend.
>
> iwd has the required information internally.  scan_bss stores the WPA and
> RSN information elements, and scan_bss_get_rsn_info() exposes the parsed AKM
> and cipher information.  However, the stable D-Bus API reduces all of these
> personal network variants to Network.Type="psk".  BasicServiceSet currently
> exports only Address.
>
> This causes a concrete integration failure.  NetworkManager maps an iwd
> Network with Type="psk" to NM_802_11_AP_SEC_KEY_MGMT_PSK.  A saved NM profile
> with 802-11-wireless-security.key-mgmt="sae" then fails the normal AP/profile
> compatibility check and is removed from Device.AvailableConnections, even
> while iwd is successfully connected to the same network using SAE.
>
> Observed with NetworkManager 1.56.1 and iwd 3.12 on a WPA2/WPA3 transition
> network:
>
>    NM profile key-mgmt:       sae
>    iwd negotiated security:  WPA3-Personal + FT
>    NM AP RsnFlags:           0x188 (CCMP + PSK, no SAE)
>    NM AvailableConnections:  empty
>
> Would it be acceptable to extend net.connman.iwd.BasicServiceSet with stable
> WPA/RSN security capability information?
>
> The information needs to include at least:
>
>    - advertised AKM suites (PSK, FT-PSK, SAE, FT-SAE, and so on)
>    - pairwise and group ciphers
>    - management frame protection capability and requirement
>
> Per-BSS properties seem preferable to a Network-level value because BSSs in
> the same ESS may advertise different capabilities.  A consumer such as
> NetworkManager can aggregate the capabilities when presenting the iwd
> Network as one logical AP while leaving BSS selection and roaming to iwd.
>
> One possible API shape would be an extensible read-only RSN dictionary on
> BasicServiceSet, similar to:
>
>    RSN = {
>        "KeyManagement": ["psk", "sae", "ft-sae"],
>        "Pairwise": ["ccmp"],
>        "Group": "ccmp",
>        "ManagementFrameProtection": "optional"
>    }

Extending the BasicServiceSet interface to include these properties 
seems perfectly reasonable to me.

>
> The exact representation is the main subject of this RFC.  Raw suite
> selectors, separate properties, or an aggregate Network property may fit
> iwd's API conventions better.
>
> A corresponding NetworkManager change would consume these capabilities
> instead of synthesizing PSK-only RsnFlags from Network.Type.  Separately, NM
> should preserve an SAE-only profile policy in the generated iwd profile by
> using:
>
>    [Settings]
>    TransitionDisable=true
>    DisabledTransitionModes=personal
>
> Related reports and downstream investigation:
>
>    https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1489
>    https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1693
>    https://invent.kde.org/plasma/plasma-nm/-/merge_requests/571
>
> There was prior discussion indicating that additional BasicServiceSet
> properties are welcome when the data already exists in scan_bss:
>
>    https://lore.kernel.org/iwd/97112988-3681-4192-abb2-9a9ee6d9552d@gmail.com/
>
> If this direction is acceptable, I can follow up with the D-Bus
> documentation, implementation, and tests after agreeing on the property
> format.
>
> Regards,
> Aleks
>
Thanks,

James

