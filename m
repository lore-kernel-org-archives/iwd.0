Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122C31ACE12
	for <iwd@lists.linux.dev>; Mon, 18 Nov 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941139; cv=none; b=Oe5oPU2rFDII/0FqR3Na7kiwQX4+yMNSVOR0EPfZgf8rXpCSQ26lz4aPl8R+DJiFX5hVIlIvLI37ulTF4ZfgAG3jeBSXCUIUFk5JB+r+Vk/Y7IhmDzIJj/rDNk+C5z6h2elhQNMkXJYxyr/FVDUwQv2Y2EZsKTDDnRHxvYm1h9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941139; c=relaxed/simple;
	bh=/kisba0z4HDuk+p9STKmtetMYdtnIX0z4JcYfWMuAMc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=c3IQYx9r+1pTf2Ma52xdzSf7QvZ8Ut24q86Am5gTv6dzaAFaxYGkOG3SFyqfFkv0Jl7hHNvErmx9uWRnzxVuI13H+iIitLoZwCPSWhUOJpoE+o9ZXpzCCaJmIJa+K7aHLXL1JWMqNZGte9PZQBKk6MgGZ+mdJ8eRU3NkVNYVOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shapertools.com; spf=pass smtp.mailfrom=shapertools.com; dkim=pass (2048-bit key) header.d=shapertools.com header.i=@shapertools.com header.b=JgkBjZCE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shapertools.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shapertools.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shapertools.com header.i=@shapertools.com header.b="JgkBjZCE"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e4b7409fso4359404e87.0
        for <iwd@lists.linux.dev>; Mon, 18 Nov 2024 06:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shapertools.com; s=google; t=1731941134; x=1732545934; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/kisba0z4HDuk+p9STKmtetMYdtnIX0z4JcYfWMuAMc=;
        b=JgkBjZCEXgPg2tYW9AXUSejeF+90HoGnWQCn+ikjLEdG45h63Ob+LPEcRXIojHls6p
         YQLB4KgnVa1lvdGwgzK+fm+BavD0BUOj2xwVriCQZh35UQp210dNAggsR/lw/7OALhmJ
         5nmekbo84iEMTh3y2X8k2saEcA7gRcVfUQn5yj2iieffQcnb7YlH5Lz/JvVqpc+oyonI
         nw1buLR4Easl6+qge3Q0D4RrTlfh8iHl2XzXj/zi7xvB0Q1rZzA4Vctdq9bgDxEkbmwF
         k68+NxyiRbaxqvQ+PgcAKaeyCiotFP92yqkY0dSAgeQFEdbWATSGYEA8ImnU17hKJ5v2
         EHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941134; x=1732545934;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kisba0z4HDuk+p9STKmtetMYdtnIX0z4JcYfWMuAMc=;
        b=MNvAlmt0NVcb+s8vfYjbt8YZ5/eEOZJ5YEWRWRDkJAHTmyNmYzQNgkpaiAL3oItoMk
         HhGSZBwlQyGW9UU9UeD+LNdrgNzIGNc5B42kJOrK390CjW9mLg0249PeW4XMD8Ue7wMI
         O+1m1drUuXYFl7p2TVgr7zonE7c9cuUgRAHa3HP8TDlaeJ/+/uOx4nKRoE2P6oQrRMM+
         U1Tn2VfWecMZpaVuW9Q2K/vtXcP1fobDuR6m3PI3NswAEKF1CAblgwd44UkHvvwIWyIN
         zbzULeUZJgAoy9OAJC2GTkicOPM98G4HWST81GTz+uaYDuJ37fZO6U3FIm9RSC8FlmmW
         3yWw==
X-Gm-Message-State: AOJu0YxSXz92Yjf1Q6XQAvjaVw2uuBoP5HK8KAEsBHB8PqQCax4MfdwS
	AcldKZcveFqnazcKxebRE0iGXUGB4ysiGsbbdZn3tb6MXuOExUo7KBWcoe+3CpxXVHpdGwXDyZD
	yj6dk/WvHJCUA/y8ghsIru326r1FHWN7M4lvtYyvxcUb5f5K5zpo=
X-Google-Smtp-Source: AGHT+IG7gI0jaj0Xnz+fqUBxwwLMiANxQHCkMTM6nIbwQPrRfy9KqoZIA95OwSe4ZDdbA6T1Ei2NtrfPfKKWSFoWVPo=
X-Received: by 2002:a05:6512:32ba:b0:53d:a9af:fa84 with SMTP id
 2adb3069b0e04-53da9affacamr3000500e87.22.1731941134199; Mon, 18 Nov 2024
 06:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Jeremy Blum <jeremy@shapertools.com>
Date: Mon, 18 Nov 2024 06:45:17 -0800
Message-ID: <CAE+F7TH5E+J74b7zf=_P-cAPFnMkfLn38GL5UKJAo+MT_dhW9w@mail.gmail.com>
Subject: Infineon working on INFFMAC to support their chipsets in mainline Kernel
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Considering how of many messages on this list tend to end in "brcmfmac
is the problem", I was excited to see this news from Infineon and
wanted to share it:

> Regarding support for our devices in the mainline kernel, Infineon unders=
tands and values the support of our products in the mainline kernel. We are=
 working on a new upstream driver called INFFMAC that will support our prod=
ucts in the mainline kernel in the future. We are engaged with the kernel.o=
rg community and expect this driver to become part of the mainline kernel i=
n 2025.


https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Cypress-Linux-W=
iFi-Driver-Release-FMAC-2024-05-14/m-p/900355#M3249
