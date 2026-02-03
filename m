Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0E2248A8
	for <iwd@lists.linux.dev>; Tue,  3 Feb 2026 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155562; cv=none; b=gYnSiOGRlEWyPu1aQmR+sUbbvBeOmRtEfkrBBvDe65XDgCRFa5vh44KqcEX5WsBqjBeWnvtyp/M0IPSKSBTdQU9X0zgWil+jXDnWYvrzgGHoUHXkvZ3UwIaatuQFV99gSZfGtbzrif/bpvyrf6hq2kkx64rYN+L/3d6/BBgR/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155562; c=relaxed/simple;
	bh=Kq5haCWpnsYadjrQ6EtDs2vYxY3uLJKf0sIcwrWuYJs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l7ZKeNmIa6yfOz2bO8ydX9eTih8aXoBLuNRTQ9KKc/9Ej8N7AqJr6TTb0X/HObdc2FO8d8pAgxJbFMG/PCVhnisguDwgtfJcEQtNKjSzkfNSwPYtZqJzKvLcHliDjT+qf8HNCf7L1C2tk5DvBnXH3YnF1yqCR0blDx5MdmZVeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-649d4690174so1285791d50.3
        for <iwd@lists.linux.dev>; Tue, 03 Feb 2026 13:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770155560; x=1770760360;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MseaRDKCSEIuf1XT/u8nio36ppzeVvMbMKGKadHJ0z0=;
        b=bvP7G4R4CVTzmY9fnIhNFlrdH/g5jhxFo05SuO23pnQN/A/DY2hp5nrBTUzZg/ioL1
         zjS1fkIhb50af6m5ROsVzTIFU3n9axtxpXQwjUE3aqbCLe7YvD3Vgf1FV9jm2cN+e+Kf
         aDDhO40D3kcN4vLyZykRto/3PfxCEIcfwY7+hZTtJRTFkLg2gNXQGg+GtxYlz94yFHOK
         yLp6GKcgKKJv1a243cuATons8rtatJZLqgpFey1qlLLQqS3PpvIcPhhYHgym5iZIKInm
         yp/Wb3rBuaFI7vuQf9AJSChYipvm/hcfUMMKPbcDuzAHrSvwpuLKnm7Hnbtkl+gJRC/9
         zovQ==
X-Gm-Message-State: AOJu0Yx2pwAOaniSDS6iBlwrSb44L/7W1EFvyhiooQVyOlM4y2A1m90O
	o46qwriT03hP5RYXKoYPkqf59QWGHkptoRjgAxD7DI6DuComaG94Is4slN8wDQ==
X-Gm-Gg: AZuq6aJ7xupc2tAER3kcwzeuNL6dTR8qtx5hVp3P6/4GoezVsMY8rxRbTx8KVi8IR0r
	8cN2QOcCdSFGukQdX02HrqCG7OTrlkqkcMJ/rg1BvN+3CV+lG3KUISuLhfrd9UFt+D3jWggMeC7
	/o1lWLvBk1glaY6G9B6g33aIKHTElT318O1h2Lm4XSdwsjJNA+lslj/F3HoJPsVriSrQwCNv80L
	hywXYQwyonr1c0yNlQH51LgSdxOfZy6B3J4nPITtjJaorE+qAdt4ABUukwB769sWFt6nUhJMJ41
	pm7/fJiTFcmsqByJcaSXiVke5iL4f4RGqZnN4D6sn92GpVYV+5wbAtP30ZLVKNdB6sURbuvutTn
	yciUIyJlgKlrmA2siiT1JSWQrTXQ5zIJ94lcG2MYEoJbdLRqLMeQuiiYpQDVi3WHaBe3gT8+uvk
	RbrJC24fPyikV8lQEdDbw7kICCwHuWgDLbFmz/v55xeerxfSsSFg==
X-Received: by 2002:a53:ed0b:0:b0:649:d7e7:eefa with SMTP id 956f58d0204a3-649db369fd0mr772750d50.37.1770155560081;
        Tue, 03 Feb 2026 13:52:40 -0800 (PST)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com. [74.125.224.46])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc494810sm613295d50.4.2026.02.03.13.52.39
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 13:52:39 -0800 (PST)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64937edbc9eso5494614d50.2
        for <iwd@lists.linux.dev>; Tue, 03 Feb 2026 13:52:39 -0800 (PST)
X-Received: by 2002:a05:690e:1514:b0:649:674e:31ab with SMTP id
 956f58d0204a3-649db33f919mr1073168d50.19.1770155559360; Tue, 03 Feb 2026
 13:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Tue, 3 Feb 2026 14:52:28 -0700
X-Gmail-Original-Message-ID: <CADXxVSKVt4-4VYzSFOW_5-H9sDi3X-3esEBMg4+HUXU4_iGvBQ@mail.gmail.com>
X-Gm-Features: AZwV_QhJPuKJoeL_rXPF9H_QXehRe3R7TjvYONLfte_ZXTdU_DfKOoz5xKS26tc
Message-ID: <CADXxVSKVt4-4VYzSFOW_5-H9sDi3X-3esEBMg4+HUXU4_iGvBQ@mail.gmail.com>
Subject: Wifi certifcation failed test cases
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,
In addition to manually forcing the security protocol from the
previous message. I gave him a workaround for that but in the meantime
I was told we had failed a few more test cases. A couple years ago
when we tried to get wifi certified with IWD the PKMSA was the only
issue and you guys had fixed that (thanks!), so I was hoping for it to
go easier this time.  But I think there was more stuff added.  This
was with IWD 3.10 and CC3301 TI wifi.  Any guidance would be
appreciated, thanks!

Here were the failed cases.  I'm looking through the logs now to make
sense of them, I basically have a large log dump for each one.  I
don't think I can share the full test plan on the public list, but I
can give snippets to see if any of these are configuration issues on
my part.

CT_Security_RSN_STA_CapabilitiesVerification-ReservedBits-31_10603_1:
CT_Security_RSN_STA_CapabilitiesVerification-ReservedBits-Extra_10605_1:
CT_Security_RSN_STA_CapabilitiesVerification-ReservedBits-SAE-PK_10604_1:
This test verifies that the STAUT successfully associates,
authenticates and passes data traffic when reserved bits in the RSN
Capabilities and Extended RSN Capabilities fields are set to one
instead of zero, and when the RSNXE is extended. This test also
verifies that the STAUT does not set optional feature bits to one in
the RSN Capabilities and Extended RSN Capabilities fields on
transmission when unsupported and ignores them on reception

CT_Security_WPA2Personal_STA_4wayHandshakeVulnerability-SameANonce_10006_3:
This test verifies that the STAUT is not vulnerable to PTK key
reinstallation during the 4-way handshake using the same ANonce when
the AP uses Temporal PTK construction.

CT_Security_WPA2Personal_STA_RSNCapabilitiesVerification-OptionalBits_10486_2:
CT_Security_WPA2Personal_STA_RSNCapabilitiesVerification OptionalBits_10486_3:
This test verifies that the STAUT does not set optional feature bits
to one in the RSN Capabilities field on transmission when unsupported
and ignores them on reception

CT_Security_WPA2Personal_STA_RSNEBoundsVerification-MultiAKM_10278_1:
CT_Security_WPA2Personal_STA_RSNEBoundsVerification-UndefElem_10277_1:
This test verifies that the STAUT correctly performs bounds
verification on the received RSNE from the test bed AP in Beacon
and/or Probe Response frames.


Bryce
