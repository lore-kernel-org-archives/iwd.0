Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6F14A612
	for <iwd@lists.linux.dev>; Thu,  9 May 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268249; cv=none; b=jX7DtNMoYdKTPhTqcP7iTUQOHclKFApILsBgv5t9DXyLi6Qgz4Z+1BDpsXxyY9xW5/w1Gq/yoXHI4js0dOjJN8N3uv4PYOuYDqRkHtLv99vHU8EDI6ofPCwkjrrTIZhuLJStMTmxoFi+k49HJDigxUiEKBcYDnkRwE2GqyfhXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268249; c=relaxed/simple;
	bh=Yc97za5WwK2fRHiKki5QyV8+sKKbaBzIsmtIotL0FaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jBGX/q4BEriXSwLObwEU6p14P37dvi6E6y6jBGrBowJKXgQF0GjIIOVaATb+mJyzZ/WWrRtfOjr+jmb4iKpNV7JySgDYOgF6kzaOmLVUvZTmDQ9u7ySGsGmqjikp1+byUnSbl6aOA86scjDuE23RJa8dLwJnEdtQvIl7v8DzfGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2AIStsv; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2AIStsv"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9539a7d70so799888b6e.0
        for <iwd@lists.linux.dev>; Thu, 09 May 2024 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715268247; x=1715873047; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ipailt7MHjoQLEjlF+ot/fy/Lnjy3EbdyjYvSb/IJo=;
        b=g2AIStsvb9RH65IEPmeorwbel9ZnlkFF3wfDhnapeMfDSHJjCx3Q4EBVRcKyzDyrdt
         XFma1ZMo0DCIWqVMk2MGcV/gfmbRE/pbmPcl2HGNPpLGwSY4Xvf8plWlUvulErDt+wYO
         O8HKtWnuRJ9VStNhJYJgs76RDuRUTGGZd0MdRH5CkK+0on3cYtJuqcWrjlcqWfvlLVNH
         EGYjBK6CXjGbjlt+hv3YVFXD7UL8s9hOSEsg/AixS8DuPBcLKOjuTOLsUNxziCOAHXH+
         22QLbbcSHVKKzPeSQAGIJ5N/pBxssK7kRC+O/bEaXKccEw5XB7aCpYAUOEkOrI0H/3MF
         Cyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715268247; x=1715873047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ipailt7MHjoQLEjlF+ot/fy/Lnjy3EbdyjYvSb/IJo=;
        b=SSNnXt3SNq2lm+2oO88nZC5Mi7vIhqhzEHxZ6KOyyzFan/tTbBPWLbiAECw0yERjdI
         8BJNONh0jl5RLXRbciII4daDs9UGgWUsbhTYQIUmI/QGYt6nQ1RsM0yPD3obs4yIZEim
         XnzP7Dz3uHXuAzsZWnw2hII61womAn/gLqGxAomUO4HUslUNRts8KsSHkOOKbhLjSbWw
         mrASjZxhM3c0BSVB78MNI5JXmwXOvFAknA8dZ1B+GWsCMeMhR+dEdZT91lhIOs9syObi
         29K12DkJ4qPXAoiVbDqVXuifySYKDMv8MgloaUafnOEnpp6yvnzPM+cTvAs4lo1CttTl
         gDSw==
X-Forwarded-Encrypted: i=1; AJvYcCWUhQNRRx2DzQpeuYUfsWbCI+iNMXDtiBTDYf+Tqou125RglzJsQuFmUm4q32EaHv3ceg/ooqkpaTz451ry2Bp7JqWK
X-Gm-Message-State: AOJu0YwJgB/LjB/dLvIV0h1OXmjWc/32XNMUrGJOBvW6TBt11byKCzD1
	qFoxK4NIDIGSl9YeJ0aoFr3+RqnzdB0A4R9RqavG9Du9Ub+ccSes
X-Google-Smtp-Source: AGHT+IHZLItgrILhJe5v9q0hlBF6oU3T5iACupe/kwq/vxFQT6ArQh+pSmHK7aUP+HEce6HfZUxTbg==
X-Received: by 2002:a05:6808:148d:b0:3c8:4bac:d555 with SMTP id 5614622812f47-3c98d8efba8mr1233378b6e.6.1715268247510;
        Thu, 09 May 2024 08:24:07 -0700 (PDT)
Received: from [192.168.1.21] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3c98fc7dfc2sm223475b6e.9.2024.05.09.08.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 08:24:07 -0700 (PDT)
Message-ID: <8667ad98-a3db-4243-8038-04b169492bc7@gmail.com>
Date: Thu, 9 May 2024 10:24:06 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nlmon: parse/print neighbor reports
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240508190749.80219-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240508190749.80219-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 5/8/24 2:07 PM, James Prestwood wrote:
> Adds an IE parser for neighbor report elements
> ---
>   monitor/nlmon.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

