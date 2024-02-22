Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60331482E9
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615626; cv=none; b=bPCf3UQjZ64fUOYNBPxnTflmZ1XlAjS9+w5PAGx3QgTz5p969rlN5xC9PeUB4ma6iDQ4fYTa19I28ZE+IIAdhTDGtKyvAoU+WD9WixSl8nsynE1svhYk86lNZPJWl8nxP+T2Zy7mYGo606GP+OjfK+/b6EOwraDD7dPRQ9cpO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615626; c=relaxed/simple;
	bh=YPhGy4U4xE7HQZLAjWw1Bu2TY8L18HrUgps7uZwkhxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rnmWde86cw8JajXa1WIiOKv9Df+xJKqb+0l/RA40Vaha7aPDJ7SgP9cl8Yfp7esjCdPcLSAWt5z54BflZcZpkhCuu78yRAM1kmMx+b9MDsZj8mlt8bjX9AhQAzfIyMUksCute6chzQNHIMBliac25NMd/TuwE3YcMzI33+YPdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1HOjUcI; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1HOjUcI"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c0d59a219dso4893853b6e.0
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 07:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615624; x=1709220424; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKapbjmk8whoR8k60itumfxWkEJzu5N3M4fY2lF8+08=;
        b=D1HOjUcIKavI0EPWPygvvip4yd45m460Qm2qp9+bI36B1GDrAmFT83f9sVWg4trrMT
         /PdBfsBm+ggBWXepStjf62jRWH7Uzwr5/wgGVdrr/v17ecBFq3Xkyn3xGnClyW7tTp+u
         YXiRC0MtCaJChrX0faJtNLuJqPg/qTbaK8A1THXlaHpXpNOqPMC6hgLruIjOJkYxzdn7
         V3sisV1Z78W8g0m3bXvc5sXSvtFU8vdnvuNwRZHnhs0e/D36oBZX14TWBltPTkFuxmn9
         RWFycwcSRF5yVAm5kkkwdgfVn8W2DsqjyMQ+HncYnd5iWG/2ZxSPQtgXMFL/r491DRMf
         +KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615624; x=1709220424;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKapbjmk8whoR8k60itumfxWkEJzu5N3M4fY2lF8+08=;
        b=VqqTysF8nwu2RZhPSusfWDEVcXx7mTE/XBWxiOOWejJdEesF2yg21OGjHRTZtYMXqh
         d07iLihqec7m8s6BIitGrXCHjH+9c6qDdwfhfhHPxA9fUsGD0qZOJDT8E3R4Bb4p3XXF
         ACBMOM2uARbn0hb/+ZTCAXQmN+9gWYIRjli+Z1W+IFqiO4E/JgLho/F6g/u61RmREqrZ
         M6qmeS9Lves/CbcfIcyx/csV4W+4E/gpRRs3qqPLXpfMVumGSJcGSf3503JouXV71V0I
         ZJ7RDRR0Gu9wnXf+pvacbRlZLdt7bVnVmHpNmoMBn4YIkiRTC6/Qya4kd8ptc/U+J7bk
         YxTw==
X-Gm-Message-State: AOJu0Yy5KuXuvHdmF0Xe6m1h9+4HxwToePzk4bD3F/rLBvrsQp18TCez
	M4QhfKBprg3bOvZb8Nfic4dvB5N7Hq06ywOvGqPHbxhQl7oIAWNrqCwr8P98
X-Google-Smtp-Source: AGHT+IErqbVyW8G50VGv6T4jfl7qsHc/zM+5qBNOclOdoH7xOv2hIsN1XeG5IzJ/eOsN0D4LejoNJQ==
X-Received: by 2002:a05:6808:f11:b0:3c1:4aa8:895f with SMTP id m17-20020a0568080f1100b003c14aa8895fmr17764652oiw.3.1708615623802;
        Thu, 22 Feb 2024 07:27:03 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bd14-20020a056808220e00b003c18039f8bbsm158400oib.54.2024.02.22.07.27.03
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:27:03 -0800 (PST)
Message-ID: <d5015f0b-fb62-4ebd-a088-a39a4f9f4171@gmail.com>
Date: Thu, 22 Feb 2024 09:27:02 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wiphy: Remove basename() use
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20240214205523.1109159-1-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240214205523.1109159-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 14:55, Denis Kenzior wrote:
> basename use is considered harmful.  There are two versions of
> basename (see man 3 basename for details).  The more intuitive version,
> which is currently being used inside wiphy.c, is not supported by musl
> libc implementation.  Use of the libgen version is not preferred, so
> drop use of basename entirely.  Since wiphy.c is the only call site of
> basename() inside iwd, open code the required logic.
> ---
>   src/wiphy.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied.


