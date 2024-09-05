Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9642AA2
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505684; cv=none; b=k6Btl0lvSSMhWRzORHI45Ju8hFZfvhowuWuWD+mfu5lzDeJTj5/MJce4bfdM49WeuuaIPr9fsOCmGVpCskjy0M5qgHtHvwTwJBbvaixgg/8VhHHiwzxixtU9UXAD2y7kQc4kXbU/ELfAt9me3CIceaqpcZOJmB4l1CDnoAcdWgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505684; c=relaxed/simple;
	bh=DPRGD5zWRpHlz+KtcleJRFwOBduAPD0UQljzAak5Vag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ijvw8X/5nkBn3+CAjP7h0z7yd5IF78M9BIf9IbMMGx9skC3u/Mt+o+Yv/1G/kZY1jaG0m5XDOxyJ8iscG5luozNHGu7nUrUpSJ4uTCzEEJ71xBnohL5Q7Khe/hBh4v0DxTg/p7BlNLJvgOWYouYG7l6X3kv1nToaE2JhvcRp4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8Xlwe3O; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8Xlwe3O"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70f6a1afc90so158110a34.3
        for <iwd@lists.linux.dev>; Wed, 04 Sep 2024 20:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725505682; x=1726110482; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MXc5xbHFhJhT8g45+/jaUmPmRLJd0wupH9J1R8UroJY=;
        b=P8Xlwe3OmnrCAzzEzkBrs+x0GgTuwSzUMlvRnxydxl80vbZryNWdZ84/l8lPFw6z+2
         eSFmtg7wg8SyfQA3cSDbBNaQB4lDocP8n0rrwpu/wotiTYa6Casg1MjF1Z2YWyxtfTIQ
         Eje6bPh51apNoNb0ql/Og/3HIqHvvsZN0+mb9YzW/oE0B++Vnv7Qi/RcdwrIGi1jhyFc
         4v8FzWHYD6/j5BeMCJ4zOX919DzV13rDt3IZfwJ6fEfM8nZK0pVU8GnH6BHuk3LkH1Ll
         ATBuAAx9WidC7dfy0mbsA1/YW+uHWV79jI1CXfAa4sreVReQzhHKPZr/s/bXhykKQnF0
         vRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725505682; x=1726110482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXc5xbHFhJhT8g45+/jaUmPmRLJd0wupH9J1R8UroJY=;
        b=ie0v50nwF54pk5FhUUeOqRt4J9hV3lGDwOrC4WO/ULn5pbUwVl4L4Arly1GSb0F4zr
         IUlH+mAjxRgHtbqnEVdEnmdeMt7tQiXMkJM8BijgiB8C1yPAF4g7wD32LqlSiUxTBABj
         RCPBMA2yeSFLcbOWSdqizmcc9enMiCGFKlI6qI1IVyfoRcdai5z80VF/+tfy+6zR3pzu
         psZqd07zF7DK3QAykkt7AaxlsI0oRL+nhQ8WvSOfGVaGhzYV7b5bU7xik7vCgNrya4ff
         5uay/pXi/vuRwpyoZTMqR9mC3tEjJ4QAxR0P4DEb4UgRaFcMcutZCw3N2wVhfcibIkEc
         6MXA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/zr65Z77N/FwzqlTzPEaIXztODGBM+TsRimerAaOmWFphDIb4899Vy6hawtc8ZxM8+w=@lists.linux.dev
X-Gm-Message-State: AOJu0YzHDAOgBvm6giMUoaLbSgbWFR6ETdyHydwAINh2ZVLoPIXwnshA
	pTZU0R8mDlEzv21bm4ZEZMaNqW0CH+0lJ3kifFnXlueU0UM7nl2Z
X-Google-Smtp-Source: AGHT+IGUCD6Nw+yFZ+9ndKaQc/FP5jbjrWLg+AidqgmFmj6kwc0iP2fQWGAHHQ0MO6YNEX12Ogsraw==
X-Received: by 2002:a05:6830:2a91:b0:70c:934c:b1e3 with SMTP id 46e09a7af769-70f71ee9b77mr20845309a34.1.1725505682432;
        Wed, 04 Sep 2024 20:08:02 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-710c15d58dbsm149615a34.49.2024.09.04.20.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 20:08:01 -0700 (PDT)
Message-ID: <9331afb3-0b50-4b8f-8ced-bd94806a73c2@gmail.com>
Date: Wed, 4 Sep 2024 22:08:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: fix build with INGRESS/EGRESS definitions
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240904151122.298818-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240904151122.298818-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/4/24 10:11 AM, James Prestwood wrote:
> These new values are undefined on older kernels (e.g. 5.15)
> ---
>   monitor/nlmon.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Applied, thanks.

Regards,
-Denis

