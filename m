Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F541C76
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700544; cv=none; b=S0qEFY8QCdRd2ohANPgRUgWxCir1TCY94RuatC1KU919NMyNtCsmRdPzdoQAO+lPmUb/aW57oVWoT3TaWZ+d0XFWbcS0ze19smya2fMfc+x8ET3l5FwYrLN7ZU+tIyaCWmhjs/1bwcJTT12SdVn9dqVx+6400P0AP0CZ2zYdWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700544; c=relaxed/simple;
	bh=0RfnV6b8JvfPiCH9X4jWbLOaWInrjHBJSKkGLwlN48U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VldVewY9bCf1XFWB5CyTJo8FXjWdWeVNt8mpN6NChTowu1NPlLN3qRpEGGyOwcr0JkYGpimRn8DmGzHGTiPNbMT/Ao9liV3e8x3htghXZLUUyaBeEDsKi+nWVDDk/GGYiYMPR5842MfoFZodN6LM3TON2CwzVKNRCcXv8j5ryuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7OEvH2Y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7OEvH2Y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e46b5e7c43so238829b3a.2
        for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708700542; x=1709305342; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C0SjSjPJIUi9hLPvr7xSMP95qGyTfY6Yy/cH8Mj5ut4=;
        b=S7OEvH2YyNhUrZzbGPdPlMwZikMsdgGBF9EatxBPuS1/NbVXf0q7Xj5XD7GNwIdI3D
         lYUwCSsk+xlAwdpsFfRXz+l81k+a7nc4PpZ9eRgA5Pih1Dds5toN8Tp71U+3TaVBXXpW
         8/Ue2eRalM1IJ9tsuJijFN41dpkM24UeJHmYC3acQ458GuMkMgxxLl17i/u2mZ/a9b+U
         iAcxLuO995/ygkW7vDj9kbBJRahDTlathJeFr9y/RiZEHn07+Umtip1fSzN8pw+kDHxX
         2ZcnnjYfkRUpCuKAeDliuZOW54xoS/Hqw7Ww6wogkW89q2279z5P5bBHT5rOPlVKAF0C
         AqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700542; x=1709305342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0SjSjPJIUi9hLPvr7xSMP95qGyTfY6Yy/cH8Mj5ut4=;
        b=NQOdZn5WyfWnntfH02UDbvJ3Htzs282fTHfnbJLJq8ek1li7vZc2hFTEq3Us/t9Jy8
         jHEPxE3amQNDBkRdZhXvxTk3FGCRDovQrp9H+4/67lWbjmHuid2w0ttXNqg3uXbm/VSm
         Ms2eElI2vJ6ZmCoS6Gbp2173OnhxEvhJx6kwAyxNdStKQ6g+6wBWrcigvD1DQBuWCZIe
         jd0shvj/Hfr1drcpSNFH081GmNf45zDlDE00FVuowJDrApjLTUsZJ3dpXkiCpMZ0nzwh
         a01Aqf33ZPeLkojszDWKwXFsel0ZMdITgiSuHLIZWOMP4jmRlxwAaCqvKaN29QfWqgML
         OOOg==
X-Forwarded-Encrypted: i=1; AJvYcCVyKr7I65O1Gy26iL4j+cEE6uwZcwONKIVzbGTzg1YbhrD0drxgApag0luOfdqR94YgYcpqcpkIXkR3AQwJoiKR1kXk
X-Gm-Message-State: AOJu0Yzs4IleT2GNJX67PutuHa024CjyNz6dNq2IE6cHuU74ax4zYwJV
	7jie0cnGZawmllLoc58U7iHD9JbWZC1sRB4zZNUW4pNfc/2euFyPka8XoVkE
X-Google-Smtp-Source: AGHT+IGZ8Xp0qFhabvOeoWI+lq5yInNZdlZ5cp0qOjE6RP87KuPXs1LQPDj1ZDcV1bSqIF3l3FEVaQ==
X-Received: by 2002:a17:90a:8c05:b0:299:21ef:6b5a with SMTP id a5-20020a17090a8c0500b0029921ef6b5amr66665pjo.24.1708700541375;
        Fri, 23 Feb 2024 07:02:21 -0800 (PST)
Received: from [192.168.254.87] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090aa78e00b00299947ed2efsm1546292pjq.2.2024.02.23.07.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:02:20 -0800 (PST)
Message-ID: <495f9bd9-b0af-4e9c-b9b7-99f1b4d544fc@gmail.com>
Date: Fri, 23 Feb 2024 07:02:19 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to connect to eduroam
To: Michael Yartys <mail@yartys.no>, "iwd@lists.linux.dev"
 <iwd@lists.linux.dev>
References: <njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=@yartys.no>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=@yartys.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

HI Michael,

On 2/23/24 6:25 AM, Michael Yartys wrote:
> Hi
>
> I'm running iwd 2.14 on Fedora 39 Silverblue with kernel version 6.7.5-200.fc39.x86_64, and I've been having issues for the last two weeks or so connecting to my university eduroam network. What happens is that I get an internal error that causes the connection attempt to fail with eapFail. Here's the log output with TLS debugging enabled:
<snip>
>
>
> I'm sure these certificates are correct because I was able to roll back to a working build on Fedora Silverblue to keep connecting to the network. Unfortunately, I was dumb enough to forget to pin/freeze that working build to prevent it from being replaced by new versions as I continually updated the system.
>
> I searched a bit around and found that some other folks had experienced the same issue on Arch: https://bbs.archlinux.org/viewtopic.php?id=291921
>
> That thread links to another thread about the deprecation of SHA-1 in the kernel: https://bbs.archlinux.org/viewtopic.php?id=292208
>
> rochus from the first thread was able to connect to their eduroam network when they tried a kernel with the offending commit reverted. Now, I know very little about certificates, but no certificates in my cert chain are SHA-1 signed, are they? Could this still be related to the issue I'm experiencing?

Yep it appears the issue is a lack of SHA1 in the kernel.

I'm not that familiar with TLS but based on the code RSA certs use 
PKCS1, which requires SHA1 (someone correct me if I'm wrong).

The kernel apparently removed this... they did (or are doing) the same 
thing for MD5. I guess we need to roll our own.

Thanks,

James

>
>
> Michael
>
