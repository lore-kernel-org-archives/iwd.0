Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D327366558
	for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036904; cv=none; b=kGiwjiude0I53UsTYwBrFrKCOzJ0fsyBr93ssLhpPkifmi1/pYPnCoqqzDGqAZv4h5A+MnrCMuqKzO95e0sLTF03/DLreqMH9fP0aqTIZdX39xs4rzOorLppMzrSR7EQyX7yW3ft2BRoY+IwtbpykkO9R6fVJWMwFl9CCi56/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036904; c=relaxed/simple;
	bh=T3cJNz3KxBV/3kv0sG80XaBZk2NZ0hkXsGbZ+0XF7tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C0OFB97ZbTZ92QvFuCLUnR+/gDjdCP9dtKp3bcfnI0WEH/Mjb52h3k7kYFcLskO37GRSDH3zE/MxqNVVWbF3no0oJdvPxN3nyPjWGB2QylUa9ZcZqJby4p/C6SnCEpqBAVoWVi+ZBPvjPIry20wLsYZuuUMBK8IRclmJgIMl2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fono/jCh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fono/jCh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e97863425so53525551cf.0
        for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777036902; x=1777641702; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3jN9TUQfMgogWgN+t4IE7/U1rfcMnvdE/ohFGnbtpkI=;
        b=fono/jChzjWKYCWk5C9kcO4/A76yIpt4iLQaYH9NYA4bp+otyC2NsGcDLYQrqBUiNb
         xg4ikOngDmY21eAMeVKctaZfoU0DsqWxguGH9lUPROmsXnOup/dxeIFEDhVM6Wr0L86T
         564Q9om8Qsnn451sFdeyhFWkQzHWUckOqAn+Klwm/57sPv/ea4eYOPs8xWsjDP+yAr/Q
         64dBaPCWzDoN0RMSNTy76jgDMYPh0XxQusmslHjH09lQ2W5IYtE+Ges6Xfp4kkJrlhhf
         QBJmor6kRyo0HhFJNRbNneE0s/J6V6a/gYrC7rfDwFectRmjTUDp6093ncAHanmGaCf1
         kguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036902; x=1777641702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jN9TUQfMgogWgN+t4IE7/U1rfcMnvdE/ohFGnbtpkI=;
        b=Nm0C3LjfiVhqxElf4J9hbq5X8Tjj5QCVwhaoftt2hhOTmEpQ2+qGbw6SQyJ60E3EUe
         J4nYkVClLDtR/xzPyRgGhnYOYGiX2PNDCDQLWJik2GU+oh4xMSRCLZ8w+Q+lQbU7geyM
         GJqQbeUnFbmDrnet4sdFXXkHQ+LthTtQthtLBFzLFHBbuSW2+AGwz5wKSLuXENaxerSi
         8U7JpWavdELz8dsWbxgUMCm+R0Ymk6cGBET+15Zx6XkWZLCJRIdzj6HK5nlJbs+fodnA
         ckrfs1PBGP8xPZxgm8camf5k2zoxy4vLh44LAfpkU6pblZD3M6GpNTL6bNK6Zjk1Nz1K
         RaNg==
X-Forwarded-Encrypted: i=1; AFNElJ+wKhpeoSHmA7dTBEsnDOMbF5VH4SyGRt0BGFPOQRNJI16UhvJJRUkp9/YAVqJcHVyLF8E=@lists.linux.dev
X-Gm-Message-State: AOJu0YyjQIBseqinGL8IgBoY//Om75j0IJhRz/aDY7tdVQpaxWwy2Q0Z
	VXVshGCpCEIsMt2gL5P43mlxsPvHvxj13GE1gEpRcJMOqDqL+U5K7SzXAHOT9w==
X-Gm-Gg: AeBDietDQIhFQkv410b7wu3ggjMPPGmsl7NETphqY6Rdz82WQIVP2wepPXA1JgtxkLE
	Yf5sDRHorOLWo2kGOF+kyEejkCQwj5tagXnSsd4KC8lrrzmiZpd6ye6tpCt8s6oqu+Z67N8Hgz2
	zc+f8/AgAXsu3tc1CbRFSMY3mrAam+Qw2Ih2PHYwYMS+wHxmLne4J2t0WAkHXXTewnCApSnf66V
	9kGyBcmntmkd/zp6o1u3RHi1YiwDocmNUruHOKl6lFWiStDT9VGLS58ve98favjNKNG33sv7d1Q
	jmq+kxf2u0bR9gvJ9y6PxRSCfW2xZfG8V7Fv0oFEi276vNdRSKNgXqNQldh0+RSx/YvlBE9sWkb
	inA32pW1JIhFl664rz3wlEuLN8vaXCsAf0dV0lbgCe7eyhrUHQQJm+rS4qrRlDZ/2xYKcqxLxS0
	0hghC42+udSuNUyYAGcgmx1Rg0KlVY8MfwpB2f/81L26/MwdTgiHNdKlCxZnnEJdpVB1qx
X-Received: by 2002:ac8:7c55:0:b0:50d:83de:4933 with SMTP id d75a77b69052e-50e36b406a9mr468667671cf.20.1777036902216;
        Fri, 24 Apr 2026 06:21:42 -0700 (PDT)
Received: from [10.100.121.202] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39495192sm192923411cf.27.2026.04.24.06.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:21:41 -0700 (PDT)
Message-ID: <1b202119-a27b-46b5-8f4c-d8b3fc536b7d@gmail.com>
Date: Fri, 24 Apr 2026 06:21:39 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] agent: add passphrase storage options
To: Matthias Kurz <m.kurz@irregular.at>, iwd@lists.linux.dev
References: <20260424083209.383093-1-m.kurz@irregular.at>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20260424083209.383093-1-m.kurz@irregular.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mattias,

On 4/24/26 1:31 AM, Matthias Kurz wrote:
> Add an agent API variant for PSK passphrase requests that allows the
> agent to tell IWD whether the passphrase should be persisted in the
> network profile.
>
> This is needed by NetworkManager's IWD backend for profiles where the
> Wi-Fi PSK is stored as an agent-owned or not-saved secret. In those
> cases NetworkManager can provide the passphrase for the current
> connection attempt, but IWD should not save it into /var/lib/iwd/*.psk.
>
> The new RequestPassphraseWithOptions method returns the passphrase plus
> an options dictionary. Currently the only option is Store. If Store is
> false, IWD uses the passphrase for the current connection attempt but
> does not write PSK secrets back to the profile.

Do you anticipate additional options needing to be passed? I'm not 
really liking the idea of adding another agent API. Another option 
instead of a new DBus API could be that we have a main.conf option, 
something like:

[General].DisableStorage=true

If NM is always providing the passphrase via the agent API I don't see 
why we'd need to keep an option within the network profiles right?

Thanks,

James

>
> The method falls back to RequestPassphrase for older agents.
>
> NetworkManager-side draft MR:
> https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/merge_requests/2402
>
> Matthias Kurz (3):
>    agent: Add passphrase storage options
>    doc: Document passphrase storage options
>    auto-t: Test transient PSK agent secrets
>
>   .../testEncryptedProfiles/connection_test.py  |  27 +++++
>   autotests/util/iwd.py                         |  14 ++-
>   doc/agent-api.txt                             |  12 ++
>   src/agent.c                                   | 108 +++++++++++++++---
>   src/agent.h                                   |   1 +
>   src/network.c                                 |  12 ++
>   6 files changed, 159 insertions(+), 15 deletions(-)
>
