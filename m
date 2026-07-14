Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF837E5D5
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061389; cv=pass; b=VMBSWHXInQLVPxOwjqpznqulN/C3pssyAwVGiug+LEzKhq3bVIwywnt/4cIZcI2EN0KjqNofI3GPD/6Vf/ppFS0J+XPTok/ghJePg9xi2VU0ON61767U95zPek/eh2kjGyQXtxS7hb05Hj/k7OeoR9Dd3Dq6IMUNVbXokAxiCIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061389; c=relaxed/simple;
	bh=T924ZBDqUt7+rnoof/NicUogj+xCkNq0m+m4NlQCl48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnIGsatnBPQAp/KHL7p9UtGYeGsQskvpVoQsgitodNdBU07QzT9jGa4NetzlFDJdIkvBZHNJrmHrlF6W4wglJKY4mzTWqDAt8kEJmBjRsaZve3quEfISZlf06qf+/3MK/n3DGpjRz1q0BwBunbqkY5LjV7F9tO4CNyYU4TPyB4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpawR8rA; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpawR8rA"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51bfb91795eso42089161cf.1
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 13:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784061386; cv=none;
        d=google.com; s=arc-20260327;
        b=IAm4zNe0qTof8ozluKEvNeb6PvhnltFAmoOOWmmhuqcunBbs0HBVR5PwX4LwxDNT8s
         dUptk83QLIQjFMb9ULonnrLgQwA5s3Jm0IUZNPhgCvoCYk9/GOTlNOMXhj6ECPrm1qIm
         Q5Uw4xL7iaiiiNI9jLn7WS+4uetgQL7+UHzoB9xb/z9pi8ntlX9VBU5aOyGD2wVthi7w
         kKW95PW2GClB8soxi2ZJTuF+it2MpMY0hgmU24ryzeJcarj5Ozw1y4ISvQYNcEfmoLYu
         jduVbbXirUKHiAaFUUNnkb3eeWP7uXQ1aTBGR29jTXKlR/smBCfFntTM+ZakrQaUkzp3
         c1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=264Z0EqMYT6qtmng7YhDUsn6tv6CWUODTrybOGjjw64=;
        fh=lOB+NE21i+DlK11xqGcqr6uTCV2U6X/qbNGHyNqUyZk=;
        b=E9iZA1hBT4RTaJJ6k9Ru1XNRXbhQT/vgUSqFFKk7nZXGGyMt3FPmEedwCZ6KGn7jZn
         VJi1aO1RucZfJ4GDDMFZaOd1QkghUIyhOSIPw/1NbV8EhWf01zRhhWfRcYnpLUbZDIFl
         jIvnrn4TwH+rdMSGbpEusixSV/rVxFAOSjwB/Qgs0QbNcBy8oKKAR41TLbVmWp0Q3USj
         KBelSXSYssmP1rUKmqXzpT5Afb9CHIw7Y+hYPvsqFhoUbV4BDLHmfkFHF5/xU50ZW+ei
         um/6KJR5To18/QraX6LS4rhoOF3UUj4jeUJG7hg1c9E104voOLsn7KPHaN8jPbflnG2w
         mqFA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784061386; x=1784666186; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=264Z0EqMYT6qtmng7YhDUsn6tv6CWUODTrybOGjjw64=;
        b=mpawR8rAWK9gq5ts+lWvWuMupTJnelMuAfIMroS03VwT2Fflm4qeZ8TsauJ24vM1Bd
         jan+JgLKB5tqcI8pv72vaFJOUAnzdIgXBEC5yHOMQc/fpGlkayawvRNLm1qlt1huzZG/
         WR+rVvIhrG5DM3O02MggsTkQ/4D1Wm7vstE90oe7tDxYfoc+pjEOcg2mTEIeWrAVplF2
         liRolTg+xyE7j/vh2s4Yozz99JIKquT/ngsywZKNHcYJkAoZE2uMXiQQ4klu1Gb+gZDW
         3/PdaQExfTD+CYENiA62ehAS5VLYlJEneSGGoAz/VSusQS14Kof4IqTK+hMDcGY0MXhG
         FUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061386; x=1784666186;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=264Z0EqMYT6qtmng7YhDUsn6tv6CWUODTrybOGjjw64=;
        b=KRwNGedPAQN68PrHEhVcZbl25amrdBuG4j0TlSdMnRsUdzDT0fxViH8om0tDH2PGLM
         Cl0zIWaJoi1lIbQpE0kpS/2b0WHGliRiSNi+/vN/olDTPH9usIhZgPYPEwSF1uFPzmov
         lrnqzvlVdDnKQrT0E1YJf076VIR6bCH4PMMBAkF3MCvCj9I2TYXSkTj8upPOm9W0GA8s
         ASyjalHZ8Qmb5yH2pltUM5p4w88Inid74pjK6tHQCeyyT3Yo1ZJ51aHRTsSXcemreZov
         zLeV34Qxodl34fpiwveuX0mAmtdGkNwT8o4OlcpqkLaFpXaWb75Nt0ihbBRsv2MeVdeD
         j13w==
X-Gm-Message-State: AOJu0Ywwpfic4A/3s846dc7XYMHoQ3allhKzAdFcGJ6LX7EGXQjnib74
	U0QD+4OMxyI0pA904ngKUN5LYa+1SIlUmjwyBI6adDR5Lo70xvDgy7t9f8AFUVhz5165JYj8Dv+
	zdUziU7/whqxCdGIvwF7kZ8LQcl+pNGI=
X-Gm-Gg: AfdE7clITZQY8ZcxUnIttaUma1hifOP/O9DCJvz9z3vu3/R+30E8oFh+wWB0Tiv/+HD
	6neY1ZTLvSU07NlIvgTfWmbDckxJRjaTqKTnq+dCKo8PaPoSgmg3aizmm8UK5RKI72JyM8D4SRP
	ZXiboh9uuJvRnQX+qUxWVadZ7dlkfkb1WAlmxRuLjjHUSGRourOzOU4szaO+xxyGjV/AxkQrwps
	QR+yJoukVxIgL7F3bIPtgef8Hu/RP5c5apx54rk3FB4EoHyQ7C1j3fGdXMl3Wgcqq1KLrtudQ==
X-Received: by 2002:ac8:5a45:0:b0:51b:fb4f:afdc with SMTP id
 d75a77b69052e-51e42364132mr34338231cf.11.1784061386432; Tue, 14 Jul 2026
 13:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC+RaJKsKz0sUivGAQHXA@mail.gmail.com>
 <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com>
In-Reply-To: <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com>
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lk=?= <aleksman4o@gmail.com>
Date: Tue, 14 Jul 2026 23:36:15 +0300
X-Gm-Features: AUfX_mxNQEb7QN7PNFysp5md9UkTcpQgH0wU7Xc1FyY3IY5eA4vAENW-GW5KHNk
Message-ID: <CAMq8zou2PAgGRp4xZsEQ0TBz7ScANnVxUJ8t-qrJ4pMe86zyQw@mail.gmail.com>
Subject: [PATCH 0/3] dbus: expose per-BSS RSN capabilities
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

James, thanks for confirming that extending BasicServiceSet is a
reasonable approach.

Network.Type intentionally represents WPA2-Personal, WPA3-Personal, and
transition networks as "psk".  This series exposes the RSN information
that iwd already retains for each BSS so consumers can distinguish those
networks without changing the existing Network API.

The optional BasicServiceSet.RSN dictionary uses the same KeyMgmt,
Pairwise, and Group fields and values as wpa_supplicant's BSS.RSN
property.  NetworkManager can therefore reuse its existing parser rather
than add another translation layer.  Older consumers ignore the optional
property, and consumers can retain their Network.Type fallback for older
iwd versions.

A corresponding NetworkManager series reads and combines the per-BSS
capabilities for its synthetic ESS access point.  It will be submitted
separately after this API series.

Validation:

  - iwd builds successfully with make -j4.
  - On a physical WPA2/WPA3 transition network, an initial PSK connection
    was reported as WPA2.  After changing the saved profile to SAE, a
    disconnect/reconnect through the stock Plasma applet completed without
    a password prompt and was reported as WPA3-SAE.
  - Cycling Wi-Fi subsequently auto-connected the SAE profile and kept it
    visible as connected in the applet.

The new QEMU auto-t test was not run locally because /dev/kvm is not
available on the test machine.

RFC:
https://lore.kernel.org/iwd/CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC%2BRaJKsKz0sUivGAQHXA@mail.gmail.com/

Related NetworkManager issues:
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1489
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1693

Aleks Man (3):
  network: expose RSN capabilities on BSS
  doc: document BasicServiceSet RSN property
  auto-t: test BasicServiceSet RSN property

 .../basic_service_set_rsn_test.py             |  70 +++++++++++
 autotests/testBasicServiceSetRSN/hw.conf      |   9 ++
 autotests/testBasicServiceSetRSN/ssidSAE.conf |  11 ++
 .../ssidTransition.conf                       |  12 ++
 .../testBasicServiceSetRSN/ssidWPA2.conf      |   8 ++
 doc/basic-service-set.txt                     |  23 ++++
 src/network.c                                 | 110 ++++++++++++++++++
 7 files changed, 243 insertions(+)
 create mode 100644
autotests/testBasicServiceSetRSN/basic_service_set_rsn_test.py
 create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf

-- 
2.55.0
