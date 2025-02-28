Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4F1A3140
	for <iwd@lists.linux.dev>; Fri, 28 Feb 2025 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783364; cv=none; b=hp8MKxjwW6E/IZ6s77/t3mKh9nZo8DEXvBy4OFsHLSLuEu5rYi5yGOlXsmNAw1Y/GmQAWIGeqMcLww5SWUKQbAzSevE6vnA0DJ7h8HBL22uNCewFXQOx6yWDjPH15nnMxOUTaWcojiaFlZ3vgLLwahcPbiap5VxcSS7qQK2Bn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783364; c=relaxed/simple;
	bh=lNjISMXfSGhDbYw+tlkWzFzDSC+AXmVq6rS0/ygksKk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lyuo7g/ZeT8ti2I3JMSwuYEuzxX4zd7sUTKhynbt0p0UuyhLjtLmNLUIBVGwGB69wD5A+bdXmlCLSHBg+iXvCnul6V0JF0DkpZvMu5raalfUMJa265dd2gVCNjTd1PNHGMv1u+CTnzmRHWhyns74igldLXLKMx05C65Wbhu/1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNRvJCYh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNRvJCYh"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec111762bso468573566b.2
        for <iwd@lists.linux.dev>; Fri, 28 Feb 2025 14:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783360; x=1741388160; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y9O3H54/mOCXnu8/WESrQNPFSjTp2LmtJpwqkFu0aU=;
        b=gNRvJCYh4TDlYa6FOnnltvgAUlAPtCOm8J9bgCATKftaqOwGe7WQvlcm2qdMd4/MH4
         zNmwaWN82jYljltpRfpibF/WD9+q+zZRTsGZlRV9oz1kjsIHSqi3APhLgBb9gv6XNWwA
         6R4nICMAy8hDnn+Gxz2TwaVox14k5zsZTaTXdHcm4WtFVgmiochaiMeeNsujWhFyBrFv
         4aYn9ik5fkZ27zSdHIR5o+CWQ5+CNyXsIN6X/QpMsMbpHkvQn+/FCrTVQPy1ZDXVqIxs
         hnjNwB18xB3LQgBB8UlSeo5pD79m8YTj3IN2aRlpEdA3Qj5LewJAPeEfM0NswKK9Q1qI
         iaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783360; x=1741388160;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Y9O3H54/mOCXnu8/WESrQNPFSjTp2LmtJpwqkFu0aU=;
        b=tEYeYHMZKcm5nHrVUAbSODPWPPZKRn/+lsxiHLV/B7W1VLuqFXYzK7LKxMhvOJnmg9
         ShMPQfZYTzd7qtbwrzXyelV0TIH6J2IDJMd5YZEvYrW8fcBI3zyVl0QfZPiBeafMx84w
         bZHQtV7tNGlbbRDvlufZe7uL54R42k7lhnLHd0UXUTdRsFqRdYbJukqFW1SRQ8d9iVeH
         bZzPcPiKohrxtiLapFbbQwqLYU9tFOzoapKhB+vdgbSTcoXryEaCsNVPnqVDLcooecxN
         XGpI9JzOA4YILu2voDTRuMGa0SCtxHnpB9+z44PvMdE9dWzIfpKdHF1lg54npt9y2lKE
         fFlg==
X-Gm-Message-State: AOJu0Yx+W0M9lu0FXyIn4pyAbUNC7JpZgFUqsfTGaGNfatz0rYXDIxvb
	sAQEySw6oc0LiCVjjW9P40fnbyWhgL2xk3ww53zl5Oygczkd7vAVqioOkNYuWPogJfq7EqJmqkb
	cFnzV0vqs/uNkTGTABmUosC7A5iEkfnhE
X-Gm-Gg: ASbGnctKT0PYt2sdW5HOBw17YQ3CjdXfUXJ17YP7DF7WiVXaJv+TAcnBfxuFwgG3qrW
	Clw6e6ex9ctEjO9hO3q+LZr3b+kbryJSq0oa53dsvwVL32+FM0YY+wyd3zoDro5cZ7Sn+quwvX7
	87ka0+hPlB/M0oHIvW6qx/c1qrbFFPyP54fdA/1kkhTQK1GviFOmHFaGZw48v4
X-Google-Smtp-Source: AGHT+IENF4wSkgr+WzEgKrPfr75PUcS9SXG9iiLruBWtfeLODJBeNgQAZQw75ZkbgqhJJAf5sP8ez5RP+bt8tgLDJVU=
X-Received: by 2002:a17:907:3206:b0:ab6:362b:a83a with SMTP id
 a640c23a62f3a-abf25d8fceemr622735366b.8.1740783360576; Fri, 28 Feb 2025
 14:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Donald <sirspudd@gmail.com>
Date: Fri, 28 Feb 2025 14:55:49 -0800
X-Gm-Features: AQ5f1JrTjbnf3leaDyWeyvtiUDTCy-edZJup5Uiv6NvHSql8HnfuIDQkB2gseHw
Message-ID: <CAOVeLGQuNx5Cr0WVcNQDJpPZk1bWKcmQ-+YeTxdruiAODBGxBw@mail.gmail.com>
Subject: systemd-networkd managed wireless networks
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Top of the morning,

Do the iwd dev team strongly recommend having iwd manage the wireless
interface with:

[General]
EnableNetworkConfiguration=3Dtrue

I am asking as I am using iwd in conjunction with systemd-networkd,
and was caught by surprise that disconnecting from my ap in iwd:

iwctl station wlan0 disconnect

does not result in the associated networkd instance from being degraded:

                   Link File: n/a
                Network File: /etc/systemd/network/wireless.network
                       State: routable (configured)
                Online state: online
                        Type: wlan
                        MTU: 1500 (min: 68, max: 1500)
                       QDisc: pfifo_fast
IPv6 Address Generation Mode: eui64
          Wi-Fi access point: (null) (00:00:00:00:00:00)
    Number of Queues (Tx/Rx): 1/1
                     Address: 192.168.50.153 (DHCPv4 via 192.168.50.1)
                              fe80::ea4f:25ff:fe44:f60b
                     Gateway: 192.168.50.1
                         DNS: 192.168.50.240
                              1.1.1.1
                              192.168.50.1
                              2600:1700:7c10:d0ff::1
                         NTP: 192.168.50.1

It is interesting to me that networkd has enough insight to know the
ap's name, but still does not change the state off of: routable
(configured) or adjust the online state.

Yours sincerely,
Donald

--=20
-------------------------------
 =C2=B0v=C2=B0  Donald Carr
/(_)\ Chaos Reins
^ ^   http://chaos-reins.com/
