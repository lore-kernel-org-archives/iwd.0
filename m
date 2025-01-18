Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06913FC7
	for <iwd@lists.linux.dev>; Sat, 18 Jan 2025 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737180246; cv=none; b=XR+2bci4567i+aEO6oF0fs4t5VNeg5QGNvM9yj3GscKXONdXGF/Oo4uPaip7zWkdJNmGeDoHmczMSfDRE9RZ4YKGEti4/1WkeVCmd1ztisKClIE0LPBh+QB+8YILLxiwrvwbVgqW4dqSXO+TfKoeaYj6NDqqO8NJf6a+O74/Bgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737180246; c=relaxed/simple;
	bh=oX6K+nBJVw7Qywf+/K5xJXb0v5xjAfHj+NiK7YmuldQ=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=EydI2P7fp4PerS3BzIfQ0NovkewgVwFZxG/gnM9EoOgbNmmXZKPFSW9TcMf/9ZTTUrXgixnczdHTxeqM/t7HZH/xpmInHsik5NbC2+QpSWXSNqGU95SDjsYCV5BelB4XoA2UhCjR9O6S2XYTlnHUIwNR1O6OWb4eInH8+62+jz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzJIs0io; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzJIs0io"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5db6890b64eso4648666a12.3
        for <iwd@lists.linux.dev>; Fri, 17 Jan 2025 22:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737180243; x=1737785043; darn=lists.linux.dev;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oX6K+nBJVw7Qywf+/K5xJXb0v5xjAfHj+NiK7YmuldQ=;
        b=HzJIs0io2fr100ysw5HuynEfSnB3pq42/Dfg4dF2KuCn0UM82/rMpiiaMOt9x6byA0
         vrChsfCwkeiCedYlgPVsDi1NIVAK7VORmyFLO+VAGffnCZuHVBoJz+rc4BAyLd4xPn1t
         7AcbI5QqIB5yUyi30IbTZNEJxKeEoAsFaZOyLrUeUTzxE50yAegqLDY5Luyw2HcKbUPF
         9z+nZVlP9AbGMLfDMie1nPPgxMkmndoe0CIFrXcVHVjshNvAhjoNSuUhdG2I8eEpRaVx
         WKuCiJGzLB9eHC5RB80vK1PSwiEwaMghH0FdT5Tylacf8KpD98ovUjDaRaZvSQ3g70hJ
         PmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737180243; x=1737785043;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oX6K+nBJVw7Qywf+/K5xJXb0v5xjAfHj+NiK7YmuldQ=;
        b=iYj31UYmd8w5Q7nPtLEsjyasdzI1brYIs1LFR21/3XOTxDAWC3nFjxILb11NFkdDm7
         BaMZ2iXsObOqhDUiB3PUfNmAd/lcpjMFuTjtNmFNrisjcfMjITlrfaK+uE8NqazxoBpz
         aJ9PsErTV1JQmh04dv0jUHz8Xm2NGYnyRYzCOS9K5dVinRYA4JHF6ZwTnsJGV+0NW226
         wdvOv6tti90L08FEyja38GkHPklU9wjGDKr+j4sMIIV2A1PyA+YL1KOj0x5/y1TeAt2F
         E7iveytOqcfZ5z6dogflmaOYntHKnxh+YQqajUlwJHl5TiCBnx/dXIdL42U/hD/U93U0
         n+gA==
X-Gm-Message-State: AOJu0Yw74Xic9oBUKGZPfNuPh6jPrGsG/6bGrUg2WWcBkn3NLIs6X+Zt
	9dhgPJUSthM6vH7V6IjE3WxrTZmklr7Ck64y9p4iV7yhwKP0XrYYlQ45Fw==
X-Gm-Gg: ASbGncsyaCvXbXHpdaDs7N8mXpi3D2qw5TAxl5k6zXUFFkdZoyCTOVZnCbFHQzB+szN
	10JutC1nSQII61QSnbt52T2vCWtWm9gZqk/ASZVXf/v5ww+d4iu6pyrDbDSLkMtDsVWSnxGzs+G
	NvUjOGeG/ynfhl6uziwPDE06O4YCH8MnOOcgwCQmljQgw3/E/dkLcmwH9FbssAsw+A3EEfG9fJ9
	1imUR3ViYEvNIbFxCi1R+UNtB9iobM6czka3mqfkrSt7H1riEoN+/659wUvD6emn3DTj1yUUZQR
	zEe0l4FG/zLWoeqz
X-Google-Smtp-Source: AGHT+IHUbqfisa0T7zf66mXgQXkCNl0eipbEZqcABdBaocf/mh0VcFhQ2Olv3LDA8qhhxH2dPWq4Cg==
X-Received: by 2002:a05:6402:50d3:b0:5d9:f362:1686 with SMTP id 4fb4d7f45d1cf-5db7d354851mr4599614a12.21.1737180242578;
        Fri, 17 Jan 2025 22:04:02 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73642523sm2621795a12.16.2025.01.17.22.04.01
        for <iwd@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2025 22:04:02 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: How to triage an "Invalid Key" error message?
Message-Id: <345AE010-CAD8-4A38-BAE1-3BCD4930414C@gmail.com>
Date: Sat, 18 Jan 2025 10:03:49 +0400
To: iwd@lists.linux.dev
X-Mailer: Apple Mail (2.3826.200.121)

Hello folks :)

The Kodi focussed distro LibreELEC switched to iwd from
wpa_supplicant for our most recent release. It has been an
overall positive change, but we continue to see a trickle
of end-user reports of an =E2=80=9CInvalid Key=E2=80=9D error when =
devices
connect to a network.

Things we=E2=80=99ve established:

* Reverting to wpa_supplicant allows the device to connect
* Happens on a range of hardware so is not driver specific
* Happens on a range of kernels (tested back to 6.1)
* Poor signal strength shows the issue more frequently
* Networks with FT enabled show the issue more frequently
* Has nothing to do with passphrase length/characters

TL/DR: We are reasonably confident the issue is within iwd
code and not drivers or kernels. We also use latest or very
recent kernels (and in-kernel drivers) and latest ConnMan
(we are generally =E2=80=98current=E2=80=99 with upstream sources =
throughout
the distro). We suspect a combination of radio properties
(influenced by poor signal and features) results in an error
which is not handled correctly so you end up in the wrong
place in code and trip the =E2=80=98Invalid Key=E2=80=99 error instead.

Our project team are not able to replicate the issue with
our own devices and networks so we are currently reliant
on end-user reports. We also lack iwd debugging experience.
However, our embedded style distro packaging makes it very
simple for users to update and run an image tweaked with
iwd patches and/or config to get the output required to
triage the issue.

So I=E2=80=99d like to understand what needs to be collected or
patched etc. to help start the process.

Thanks in advance,

Christian=
