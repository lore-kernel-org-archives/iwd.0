Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556717578
	for <iwd@lists.linux.dev>; Tue,  8 Oct 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404074; cv=none; b=hg1i0/XeLWIBHEB+3EgC5sZ3axfe33ExfofDtHRDdyzc3nzoYE8zaGP26g/xVr3ogVAOg+uuUb17XKCFN+GSjgjvd9SzteegADDximfJODvVKg/0YJBMLmCYRA+AA7gmkk2FWESzjQPMxkEE4MOo5SohbxAXqfecHF25u7Je1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404074; c=relaxed/simple;
	bh=ZRe0spkSFcr0jB5fkSDLz0P5cMelo4mzOYWZTX87G2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lJa+d/f/J6FYCmi5dRfkmSJTQYzg1RhEQzjDMr2QXCxgk1Y4dw40xIkbER7jjrV/mg754GHc05xlYGWcBsszTt6vdDiB33qmfuFYH9Bq0UeSJSRl4LAIfZ/h4b1jDR7u7WGOFbF8ffCNdCi1wrYfKij2/p5/rlyz3dv1qH5w0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iyjz4rth; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iyjz4rth"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e3e0a8aaabso276674b6e.3
        for <iwd@lists.linux.dev>; Tue, 08 Oct 2024 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728404072; x=1729008872; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHqhyCzIAfriTFi01mgEBje3FEim30CCBGNLB+pX3Cg=;
        b=Iyjz4rthJFWxMTzICnBp4YRpVE6Kv3bORKrKpdaPgWA8cCMHWg8+r3QdObFHqIvc7N
         1ZQItgxO90vE2NYEq3wlOsEfDu4ljaqfg2U536SWpO6aR2wIkoOUJeZsQDaFDuPWGYLM
         h7cBIu2U1tEAcemEe8E5Kl7z1XbYDv5aM9lxyPj+GuZHo/ppKFJrE69XWznqh4SPEkDG
         fhu65Gr2CaD75Y81WyI4B7oK+6C66Cs3XuVwe0BApK+cW3ghhix4qbtowawmtsKOvgVG
         FXkGhv07NQzl32EBbtVxkVDCGMma94NsV2fQaLXfjzXiE+opFObnOhRuyKXFJlP7Yquk
         fezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728404072; x=1729008872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHqhyCzIAfriTFi01mgEBje3FEim30CCBGNLB+pX3Cg=;
        b=FYBLmZLsa1t6/vaUI+GvHpO0EnM8D67pXUPWRu46tA+GzL1nmfYgDabTeSuZLrDrn1
         CHwppJ8XY9Nzs1nrTbypmGfTMuNMGZOjJDeW08Uymxft4fjjw+er0jxyGb5hUAHzHRs5
         SAVVg7L7f9wV9leg19byeX0Lw8FUMxZi8tXmIxYoqMGZBau6etm3BdEf0FggYWyt1kds
         w+lRSjmcKi0YWYfFu8pmXdqPK0V1xspr/QtIxiNlaFxf3K0wcYJCIZgmh9SNmVTFwf6T
         MMgmPIO9Iymqt+QboiuaEPOnN3J2ETppj5nuVaa8lASYuBsHMlWgG5toAPI1iELCwv7g
         p/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUc9AkGOU9XFz7MHfAZNJAJuZOqFbwC5luf39sbulR7ZvXJnOeXA2dgVcRWx/BTSJdIhCM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwtmuQSkB5EoIsQLJRgg5HSJ+K2JRaeyqCLwBag30X8YksWNRrZ
	JpS2C76u2euGMnBViQy8XNvzaQCxEg3wpbteS7ezRxkmS2Yy6SKi
X-Google-Smtp-Source: AGHT+IGyDTXx/s3dzJSeVcpb6s69dcCOK7hq+jU+aCds2D47mXZhZ/3ZcqKPdKQRRIHPLPiBUns5QA==
X-Received: by 2002:a05:6808:3205:b0:3e3:9773:1d5a with SMTP id 5614622812f47-3e3c1534e3dmr9935141b6e.2.1728404072493;
        Tue, 08 Oct 2024 09:14:32 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3e3c902a30esm1982880b6e.24.2024.10.08.09.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 09:14:30 -0700 (PDT)
Message-ID: <c14f2467-52d3-4be0-a288-a65e1612c558@gmail.com>
Date: Tue, 8 Oct 2024 11:14:29 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] band: add "GB" as a valid alpha2 code
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241008144712.403893-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241008144712.403893-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/8/24 9:47 AM, James Prestwood wrote:
> The "UK" alpha2 code is not the official code for the United Kingdom
> but is a "reserved" code for compatibility. The official alpha2 is
> "GB" which is being added to the EU list. This fixes issues parsing
> neighbor reports, for example:
> 
> src/station.c:parse_neighbor_report() Neighbor report received for xx:xx:xx:xx:xx:xx: ch 136 (oper class 3), MD not set
> Failed to find band with country string 'GB 32' and oper class 3, trying fallback
> src/station.c:station_add_neighbor_report_freqs() Ignored: unsupported oper class
> ---
>   src/band.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

