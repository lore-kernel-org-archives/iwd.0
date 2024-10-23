Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEE1FF04C
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721095; cv=none; b=j9L6Y9LlJi6Wm3+SQgTyr1OAT5cIy1MgDixoqnOradyEeYPV35eQWRYH/ZbNTXHDff3xf/NEbsCxsXh5Bf4/JExbgbMMNzDKR66hDCfp5esSTSPt3RQNp2TKY3PzjH5Fuotz/X2o3ccoBU2oJ8bac9y7KjXQ1MFBUjOLkTaQPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721095; c=relaxed/simple;
	bh=PX8/XRH8kVoU5EMwZyT3XCe9ufCE87zGl3e4Ey0IfZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AzbJE4PuEDw5wCtHZEgCgFYF7UmCszV9m3Eedqw8u9cmGQOYvwGuMFh6CuW8NIUmRh0Y03l+2S+5S0TBOlyoK43MYwUgPOwt/uOcsIBD1fQj1B3hQDwAD5jUlOU8Rie0mIjrBMAFDGsY0blrqQGFCL30wDeQ2V/YOYfI40qy4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEIZBJkN; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEIZBJkN"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7181b86a749so184951a34.3
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729721092; x=1730325892; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3OdjVmn78mnuY3m8gTLrh3u13Vb4RxIGd6SH6EXJ0gg=;
        b=UEIZBJkN5r4QK7858hEjJKPo0Z1qTHIlKKSEhZOja+8rnK56CmI46J+1bZrjnbbuus
         q5FYmlQV+ZLcGRcGMMNtUw1eC2y/b+EMKanaM+BeV9GBtNvQnlqsWdPuiMLcAGhWXeT+
         C+0QwCRitgLat8TXCh3pqiTcLAmFsyco1GdNoqebrTVOKmK1Zh3ozPNC76oXLAJrT9U9
         OkhVwzlw507uGJG6D3gfu2LYIAk1lZS6l2NgwOIEBa+UOzHeeA8BB/16eBYPMLlt0Hwq
         cwzSwlCFd6e5IfNyOQHm5EWLiLxI7fR99PrxzLq+jRe/MWLHtbQ93X6R5Pt/7Tq8sWu3
         l71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729721092; x=1730325892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OdjVmn78mnuY3m8gTLrh3u13Vb4RxIGd6SH6EXJ0gg=;
        b=QzGCcEZW7Yt6HniHcW4ZnjzwaAall9y90pMWK45BKd2kmbHy1AzuqEjgH/4bJ8Zr0e
         e04sfOXUwO8jSRJ6i2F7jEFCLxMBO90Ue2FgJeIM2YIJOwFozYwZ7Q3noaf+qdYNEWXd
         sRzlBUWvXF25JsOvCFnr/3hreXqCUWDRUlpZA1LRNdHXzG/CcFvpvPpdNjVBU0ktcw34
         YriQ1d2w8jrjTuVjcvuAHDBtx178bR4JaxUrVLYpzSYvvgBbV7TagL55q4af9lCuLSgP
         JqFYQNFPpMUwwOk1ufIuAc6CNmq1hvCVruzDZVkqA/XrQRj6WpyHVO7N7Gb4/OM1ZV6P
         Qijw==
X-Forwarded-Encrypted: i=1; AJvYcCWSOYITIWBixwXYdM9f4VLPxG6pCoaaBfGS+JogJJdkNgoaRsOcFx4hV1Wd+K8oFn/Af0w=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp9hLvfQ2nqLzRfNplsnT4MqZ5rDhT2eIrj4ZA+xK2sTS+Z3z4
	2+TPPgs6k3LQ0Lw4kXfxd9cJAk/3fAdrW25RRQVoZ0oCSna5c7OQ
X-Google-Smtp-Source: AGHT+IFecZxIQ+Gbu95XCOuIfAFnmRLU720E3CiNs+rVhBS/2jq1kS7xE8wd49LMpejMNFO28TUaVQ==
X-Received: by 2002:a05:6830:4427:b0:718:123e:9239 with SMTP id 46e09a7af769-7184b39ded5mr4887366a34.13.1729721092267;
        Wed, 23 Oct 2024 15:04:52 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7182eb4041fsm1890891a34.31.2024.10.23.15.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 15:04:52 -0700 (PDT)
Message-ID: <38b1af93-83c8-4cfb-ae63-5e480ac4420b@gmail.com>
Date: Wed, 23 Oct 2024 17:04:50 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd 2.22 scan fails but... works ok with ConnMan
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, iwd@lists.linux.dev
References: <CF5A13CE-18AF-4A33-98F9-13FA353657C4@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CF5A13CE-18AF-4A33-98F9-13FA353657C4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Piotr,

On 10/15/24 3:56 AM, Piotr Oniszczuk wrote:
> Hi,
> 
> I’m using iwd 2.22 as default way of automated wifi connection in my project (https://github.com/warpme/minimyth2)
> 
> Some of my users started to report issues about not able to establish wifi connections.
> I asked to do 1st step verification: launch ConnMan (https://wiki.archlinux.org/title/ConnMan) to verify is HW working ok.
> 
> With ConnMan users are able to connect so HW is OK.
> It looks to me like issue is specific to iwd.
> 
> With iwd log says like below.
> 
> May somebody from iwd team help me to solve this issue?

What hardware is being used?  Can you include iwmon output?
https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html#iwmon

Regards,
-Denis


