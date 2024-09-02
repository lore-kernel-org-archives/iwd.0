Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6E156993
	for <iwd@lists.linux.dev>; Mon,  2 Sep 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258872; cv=none; b=mdMbZ01IlBx3BeAOhT58R8YbsZXhkkTiIDmhWLvnhsNjq/LJMFHB6R2fzGCnOUBUBVd04geferLyQeXXVhmpVj5jQ5P5Ol16we3dL2TA9UAsPkv5lw5WqTD+aJfuqGSGVVSmXN6WulslQVlKcPmxsJxPQOKukifBxI5W0rg+KY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258872; c=relaxed/simple;
	bh=PxDTYs2cmF97tMiiln6+GaHlGA35PNvkarsSDGf1KQE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=chfqiituaaFmGyw9eFY7yB7KpGfclAnLW0Y8CKy7dc2w/TXOCZfkToWeVEiirWRgS8JPNaUD2jZU3rVLIXhHhHAowFCr4+Yk6xOmkBFH1nNUFkaB+SStHTbmMDsdnRkJZ1ILh2qvlj0oCQ7tNuuSyGCIs1Ba5zLBLN9fQEymCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTqLyCO8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTqLyCO8"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86c476f679so443580166b.1
        for <iwd@lists.linux.dev>; Sun, 01 Sep 2024 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725258869; x=1725863669; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmXtyhiNZsWz6D5DzJXwIrA9h3mB00/xlVN2YaZFU0I=;
        b=dTqLyCO8dz+UIl3DLXSIB9j0XbWzTDSBBvul/fPuMT2f2DIXeWYIxc5u9R9ACZo/ll
         ctOlrB33IU2AAUgNnuPIccBKMtNLFFpf3xje+j4jUjVdr7mI1YiZu/QqVUsi2opbeh08
         WZUo+m4pEx/ycmn7loV85c4m2+fHun3ye/qA08QbeS69JGjfn3mT7BzhqqIIZp3n4pNg
         7aZgVIUFZ3mHgKbBVvgu+YRhwH/hs7qkXZMmuPHBuFcnRfuqvx/lyZ/WRl8Ym7Uv1vmm
         2BWltLU26E2L38O6orHupC0Ni8TLz/R7iu5q7BEnz2YBXpB0XwqCBW7T1Bzw2usVEV68
         FOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725258869; x=1725863669;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmXtyhiNZsWz6D5DzJXwIrA9h3mB00/xlVN2YaZFU0I=;
        b=Qp4Vq7x1c4FHrF8QCGVicXRTKv90uUx1WY3P+dqZ8+74WYpWgs9awFYlwDM0CsUX6v
         AbOYMBSQlFxfy0xahEspNvJghcLPLe3ma4mLIxP7VZjfa+MJOCtdDO0JWhCMQCKAkGBV
         jfXQLAgB9oyDC2IsHLJ8DvRUoDQdC9ZjqvaEAf+nOSA+g+tlprZuW2vfYY5v6Mok4DOE
         zzGGAvj+gbpEiu0Rt8uMCT0hhnuD3CrTK2OUeWXFAQ56BdPSLtUO1MRwJ5J2NUfI0RPs
         g7Wl5mVb8HxyKPrkt1pKDhl3SHo2LbnmUeCrbIEULWrdzSvz9JHLNS5n/CSRJ5SdeMwC
         3TkQ==
X-Gm-Message-State: AOJu0YzpAo0LF+aAyUMyAAgqbqbIJMiWvUsz1X2aalJGyy7OlMms/BYn
	I23RCxn7A2vgz+iwXFyYls9/I/tBZjee7HNjouubdc1gwOmy3YnFD21DdeP6DzgrJD4PklqibKK
	JwC94pOYC7gmemzwrva9EtFR7mlgrt+99
X-Google-Smtp-Source: AGHT+IHlcv/1UoH6eKxF9JX9SeLJXvdTBXHcsmvY6TaJfirqWP/Bpqcnlrt1Ofpuy7N7+twLLmujHfi9AHzH+ftjzTM=
X-Received: by 2002:a17:906:c10c:b0:a7a:a46e:dc3c with SMTP id
 a640c23a62f3a-a89b94a9cd9mr406530666b.15.1725258868223; Sun, 01 Sep 2024
 23:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Daniel Bond <danielbondno@gmail.com>
Date: Mon, 2 Sep 2024 08:34:00 +0200
Message-ID: <CAO=WXSdnr7q2uJwEBvmrsfu+qpVCSTj0WVkKeRmPZi=TgTfYcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] scan: fix invalid read when canceling an ongoing scan
To: prestwoj@gmail.com
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

There was reported an issue reported in the Arch Linux issue tracker,
which I also experienced on my hardware after upgrading iwd to version
2.20. What happens is that iwd constantly segfaults with messages like
this:

[  279.974994] Code: 00 00 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56
41 55 41 54 53 48 83 ec 18 48 89 4d c8 4c 89 45 c0 48 85 ff 0f 84 f3
 00 00 00 <80> 7e 20 00 49 89 f5 0f 85 e6 00 00 00 48 83 fa 01 48 89 fb 49 89
[  280.685109] iwd[1648]: segfault at 32 ip 0000788413f05de6 sp
00007ffeb3d023d0 error 4 in libell.so.0.0.2[1ade6,788413efb000+57000]
lik
ely on CPU 1 (core 1, socket 0)
[  280.685125] Code: 00 00 00 00 f3 0f 1e fa 55 48 89 e5 41 57 41 56
41 55 41 54 53 48 83 ec 18 48 89 4d c8 4c 89 45 c0 48 85 ff 0f 84 f3
 00 00 00 <80> 7e 20 00 49 89 f5 0f 85 e6 00 00 00 48 83 fa 01 48 89 fb 49 89
[  290.573368] iwd[1686]: segfault at 32 ip 00007c0b35d49de6 sp
00007fff86c509d0 error 4 in libell.so.0.0.2[1ade6,7c0b35d3f000+57000]
lik
ely on CPU 2 (core 0, socket 0)

The issue seems to be resolved by checking that results->sr is set:

- if (!results->sr->canceled)
+ if (results->sr && !results->sr->canceled)

More information reported in the arch linux gitlab issuetracker, under
gitlab archlinux org /archlinux/packaging/packages/iwd/-/issues/5 .

In advance, thanks.

Br, Daniel Bond
