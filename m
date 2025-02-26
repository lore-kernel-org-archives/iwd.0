Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165B215F65
	for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570575; cv=none; b=s6xiGy8uc2DoQ9t1S0S6yEaGJUOBQbkF0rfdWJ7iiexlK35zJ2Sn+UH941pSFVIRSA+PvxT+Bf/K7SWRCqfwXXnnfuTNR3ieJPrn0PObm+HgpnpRycF0AvolmrVNFFsTk1XdEXnpZ9dn/1F9DBBaet8wUQsdeMMVwnORoxYP/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570575; c=relaxed/simple;
	bh=bsmJl95IE8RNJvKHa98pRaP+i8tbaXWpxjZjQ2sErb8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Al4AVIrXOspKGpbjock8ZtxLFoTOdNoNRTNep3EujX4Tw9vUqE1MVT8qRgtwkR4Pxu0VGbjIDo40qVVnjA/LRZo12TOW3yZd7H4UrVBkMt+D+nyMiamf7QSWMFCJti/cQ6oKAXXqoOTAlPWHda07+IyPCkVv211KZTI5b5buBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km+Ns+yM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km+Ns+yM"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso11777266a12.3
        for <iwd@lists.linux.dev>; Wed, 26 Feb 2025 03:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740570572; x=1741175372; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bsmJl95IE8RNJvKHa98pRaP+i8tbaXWpxjZjQ2sErb8=;
        b=Km+Ns+yMOtkkhSkaZdx+XPEbcrdoN+yQ6NQJZPbPhjJLiaR/2ks8XkAkMpJCNL3HHi
         QYrjrcc+JCWINqRK3FRyeP31S8suzeelXvv588xxCbM3byR25lBofC+ht7IIt6QvLJ7R
         huksLxI36sE62Tlgzku7m2dbU/pBSjja/RRlfmoC1EVhDr0mE5h3dfg9TW/dM/7tqqvA
         Q6nUUYqluWmgW7MKSn/93wRwPhMTRjB6zISyF7DAVdX76NTzpe0TncGClF5QpjMY+yrQ
         ez5Y+vOnNj1J5ledJOqCNEnpGx9pC6cgd1PnPgCY8udpcJKBZFXT5WnGxknKPqjJKBWT
         jWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740570572; x=1741175372;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsmJl95IE8RNJvKHa98pRaP+i8tbaXWpxjZjQ2sErb8=;
        b=uD3elhzWtvklHhif0GEa4Yw1FKci8In/2OIlA8dSbqmm+YN0nuSh6eu9ZjY3F6ZY1p
         aWC+OIj1vojY2yp2wNKRJXX26s9HoxjjMG+rxt6hS3ShSNM8QhtlXjfEPpm2tuyo2yzE
         iX3sz1LYQk5BrB3Bc7XA05kiJrMkhLY+eMY4ddS/TQq0XIHhpD1jvRgZnEjtJ9S+Y9dV
         ziFw15hfevpnlLRTMSlkq32IAOFMbEFZm1B+cIN9WmXT2Nvo5ZKS90Nt3W1/LgpmBfrr
         KLKrHiPV0eDj5oEaKJmR8KqstPIc4kWOafp6D0WaTZRzIR/u6NPKxPx5w5/AOvbZKa3f
         sphg==
X-Gm-Message-State: AOJu0YznImvt3weX96l2VPoVNBFArRsplccll7fWrgnfGfD6DDU//G0Y
	dS7GbLuREKyeCLV7gXkRDDQH5levSZC4UhgFDBFLDWEoQ15oUqDR0SoKponh+ZmOixKtvWxlXKV
	MJS+vo8X8+KAd88cKvv1J0X8tOCoSEZEV
X-Gm-Gg: ASbGncvTwv3C8MF4lSyvPiWXiDcEP6QWof7Q2sL8ghci1V9dl2L4vSw9iPGSQuQ5wF/
	dOfAXMtQJfDTWK3uRznOrqK49QxQ9sSdWJYW6B72NEjcIf7HMUZYFLCLPWhEsPuQduNrATxWqj1
	V1ZyyeTCVj
X-Google-Smtp-Source: AGHT+IHHA3i2syKS9+bFN/Iw9dKComc4m8b1aPj9epfRKxVoGMFqowV8q+LE5yvq4ox3ipJtFnyA+ePJ3J0WlmHEGWM=
X-Received: by 2002:a05:6402:2792:b0:5de:ecbe:5b9e with SMTP id
 4fb4d7f45d1cf-5e4455c30d3mr7777820a12.11.1740570571666; Wed, 26 Feb 2025
 03:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?Q?Frederik_Br=C3=A6ndstrup?= <frederikbraendstrup@gmail.com>
Date: Wed, 26 Feb 2025 12:49:20 +0100
X-Gm-Features: AQ5f1JoiGCGrv1kB8YnHXuJP1AlaJh8aDAcLxKY5QXjuQdO4GKqIM7dUfBXE-4U
Message-ID: <CADs2FCEpXNpdrVOjiRN6i5WG8=HayYRqQ5P-L36dj=zLyYh3ZA@mail.gmail.com>
Subject: EAP-TLS support in AP mode
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello

I'm working on a project and would like to know if there's any
existing, or planned, support for EAP-TLS in iwd. I haven't been able
to find any info in the wiki regarding this, as the only page I've
found is https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/ap_mode.html
which only mentions basic WPAPSK

Best regards
Frede B.
