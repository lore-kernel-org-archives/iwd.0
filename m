Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050997E76A
	for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119842; cv=none; b=HJc9RWtpuEho7xsUhrhaB+w9Yv9vYWvL3aN8aCRrzWGgQW1nqiR7mB0obzhpTdCCRC6PH58TGs54ThGI5KfGmsDEYCk44MhSRg47Hslsme7KoiAlg1Pg8Eeyl9NgDBYktw80RKuP358khJrk867YePxHR6Rf7DZQm8WoBqk5WhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119842; c=relaxed/simple;
	bh=lmskdss01kNpW8pxZwk5UasuuGoPQg/qFsXaYLTE7Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FgA0Nj8Tc/hcJSQvBhl8h4J3r9+Y49XVHyPEJGjy5s+360Pt8/w7MigCIyKY/2YDwp8BvJvvnj28kByFrTwF2reLSLAx29lT/juRgUUtOB7YAnbtCDURTywdmMJBAkQ0jpGqgIc2ly5coEvVrUfQiIaxdk45eNwQlTxhXs2IkIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeasuAgM; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeasuAgM"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6de83f5a004so3987103a34.1
        for <iwd@lists.linux.dev>; Wed, 24 Jan 2024 10:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706119840; x=1706724640; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8r78UOi7H3W7vXLv0f2CiPOviIkLHxwmvF5hBszHks=;
        b=HeasuAgMNMt/e6TT3J2/4+YHOtXG4Q3OEaGhoQqus9Y4OIoMMjInZ8ZDj1ulft3s2/
         PymKO+OlpCYm4bfEjUV0bbzHHG/NPqZZsHYPVikekY44yodcUoxODGLtQ2/u8zTAItX2
         R7NvkLyQYAvduPpA3x0yFUo8MmK7Onov8gTGwU16hlKQ3Fh3x5IPWOBrMg/sLbtTQTSC
         GX1qKlbvlZhCXbBwXJRqZ2iEN2ZFJVv/CnRwbSttPJYmx6MUg6Oj7dTNWZ14KNWD5JtT
         IlZmpm1Ufo1vHIYVRbRWUOcfF4sE4vbl730GGZvUIt8OzPuXKpHV9GwJT984mANGpx6I
         C1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706119840; x=1706724640;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8r78UOi7H3W7vXLv0f2CiPOviIkLHxwmvF5hBszHks=;
        b=BQxUmC+04bzg3ac1b/eYumgIWHfBgTQym3W8xXQvesDT+b0Q1I0WnddFVwwx8byRtA
         1b3C9MQIITmH/mtXHY/f7BbI14WNh0ctczF3CoraQLhomKzVKxJGhjW25Kd1IS4IZFxO
         FOyWWln7fPDqJ5lS3IpPwQkfvTMgTvHayA7MPTYNegliqxAZsZ7nvGVLx/C/JDeO3INR
         8xM3WOoc/VS45dcuPNiehESE4jydUXXmOYHCcsGs1jHQLikvPV8IdpDON8Dx/7rybMd0
         ivP7akSBP713RLk8AWDE2qqb8uNrExFSqwy+aEQeouUWY+18iHXoC3YgClDdM9bzkFOE
         Lw8w==
X-Gm-Message-State: AOJu0YwtM1qnEfgeIPqsnb7VmjdAfBlWJXHoT2kdjjVwF21e87a69bxT
	TOzEmiIiKYKA1cOybbN9YTScDyy6/TLJpuRODUMzSX3edqbSJY3H
X-Google-Smtp-Source: AGHT+IGHKPOsgH+sQ3LFI6A7+jutUeJ4BdehbJTp+QrEMMc0iCQBm/vYhZ0Qtbf6x4LbRs0o4vA3GQ==
X-Received: by 2002:a05:6870:e2ca:b0:210:b081:7bbe with SMTP id w10-20020a056870e2ca00b00210b0817bbemr3865900oad.75.1706119839609;
        Wed, 24 Jan 2024 10:10:39 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id i31-20020a056830451f00b006dba1ec37ffsm2676069otv.11.2024.01.24.10.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:10:39 -0800 (PST)
Message-ID: <703a48ba-41f8-4104-bb1d-6b017ae76e15@gmail.com>
Date: Wed, 24 Jan 2024 12:10:38 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] knownnetworks: sort known frequencies by BSS rank
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240124134001.20453-1-prestwoj@gmail.com>
 <20240124134001.20453-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240124134001.20453-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/24/24 07:39, James Prestwood wrote:
> Currently a quick scan uses the entire known frequency list so
> ordering really doesn't matter but improvements will be made here
> to make quick scans "quicker" for large network deployments (with
> many known frequencies).
> 
> To prepare for this the known frequency list has been changed to
> be sorted by BSS rank rather than most recently seen. This makes
> a lot more sense because IWD should prefer to scan frequencies
> that had higher ranked BSS's, not just frequencies that were scanned
> last on the most recent scan.

Interesting.  I definitely agree with the argument for treating frequencies with 
higher-ranked candidates as preferred, but I'm not sure that directly basing the 
frequency preference on the bss rank is the right thing to do.  A client might 
start right under an AP, ranking it quite high, but then rapidly move away where 
no APs exist on this frequency.  So you end up always scanning the original AP's 
frequency.  Some sort of temporal rank decay would be needed?

Perhaps an easier way to accomplish this would be to add known frequencies in 
reverse bss->rank sorted order.  That way last seen frequency with best ranked 
BSS would be first?

Do note however that the quick scan approach is really meant for smallish 
networks, to cut down scanning time when moving between Home / Office location 
for example.  It works surprisingly well, but might not be appropriate for rapid 
roaming in a large network.

> 
> As far as the disk sync goes the ranking is not included, but
> ordering is. This really isn't a limitation because when IWD starts
> up there isn't any guarantee its in the same physical location so
> old scan ranks are likely not valid anymore. The first set of scans
> will begin replacing the frequencies loaded from disk.
> ---
>   src/knownnetworks.c | 16 ++++++++++++++--
>   src/knownnetworks.h |  1 +
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 

Regards,
-Denis

