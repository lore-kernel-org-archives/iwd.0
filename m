Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB31F7568
	for <iwd@lists.linux.dev>; Tue, 17 Dec 2024 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456110; cv=none; b=NCSpUcxc+d38mQPbob8qR5ReTmICYO264HVNrOIlhoZ4YRmq/Hqi3Gs/jBtws2081l6WHqX3UYZUi+9kjxoy7IaSS5XEZcGhu99QnHadmPeLuIOPaUV9/1o+PecggnXbS+8xx4hNF2ffpRkOGICcIVL9idRfD4/SJbwVHE+8s0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456110; c=relaxed/simple;
	bh=i7sdnaN7BPcZvx206FReL35a4HRZMidTmtmgqtcvwys=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GwAOkk1r/z9WybBoMKOISwIKxPyVBS+IMdr29y4MZGHorKajYGjQptI/8eawqgHrO9/lbTvu5oyMxDSL4ogzPCNC5F+bs+v70WM/RRm6ikG1QZmV3vfPcORVrvHlVslmJpXvW/UgDR3vzhdjB5edQ8BUVpXhFmBOjmcptyfMdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsDyGa3D; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsDyGa3D"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so1504179fac.3
        for <iwd@lists.linux.dev>; Tue, 17 Dec 2024 09:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456108; x=1735060908; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXKYA63/21DOQZj0wPNDTGacsHvo3B8P59kAkCvH3Sw=;
        b=ZsDyGa3DOO2gmJSXtoVeNCI4MqYtL3G5kgstSKffzeJpF28v4J6GYxzCgrg0d15g2S
         oA8cLOLXZsF0//gUeIjortte1Y5sQmA6hTkDSuprBE47KaOsJlaDF/XCe/aPrwzVbyjU
         iboBC+wU1HjT+CZ3I6ZEXgoegA8My1iI4FFlOWglR8K8bqZX/QdZXVqEtYkheEj9jepo
         idbRMeb7pqQLBZudntTMaSEMNGklEconpo7UtXbNxLX54TCw8CfcmXj8VPoVBUNpXQRu
         pGyUyp9uuMjOniw3o6ELRuVC/bjW1/ZjLXsXRtcdlb0HzdcTGWwj6SU0ZMZIkatn7m0O
         sikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456108; x=1735060908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXKYA63/21DOQZj0wPNDTGacsHvo3B8P59kAkCvH3Sw=;
        b=KcIk+oObPaAhHoOoshSwZIz59nZu5i9fCD6IBvyXa7KDDN/WKlHhOctUp2J+E0nJr8
         jwOvFjUdCsWQybNiq6Tj/Mfmt0LQomAmPHKv050zDY2YckFvUMy7OmZ7p/fYnS/dGj4h
         urkc4qml84pdL+xwgjlA1IqOubIWGBgXe6HX1seQFRQ+AJw/3JKVuzr9Qnd4QOGL3ZOx
         1wFGQBk3+UbFTF2JItoL6ULx6Qb7HkDne4qsJb6sZ7TlFvWNI9bonmZGRpTRZqrZ0e1I
         dQ9k1vwqK/4JQmdg3fVkoAeBzzBRFIbAQybJeCHrKq96VpsZGKak5Jh4Da4phXQw0hJ8
         Hjzg==
X-Forwarded-Encrypted: i=1; AJvYcCVC9TgDipx2Um/WQWQdLXZBGh+La+fxvCb2MEl1c4jfIDEtsNrTbccC0dz3XnaaJhrQbc4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxHHl37SMxSxomcRzCVZJD+pi8rzNJ8Mz+8utzjl0QISRhcq8Ul
	bgit6XI7yNRMaXYvOpDM9+HSahtNHP6Hlkldzv8/SEXf8ovpZ6sC
X-Gm-Gg: ASbGncu3+ukEdDVn+3bw43kSa4XKat/hm+sfimO5tdN9dG20Qz27VbkxDKwy9W+7pie
	CCUEmXyaiTOjuWwo7NPLkCFZ0yFs9DSI9RieSYYwMR6TsMQy1YHIEqz/y7s5UBQ8zBTv4oVPEcv
	H9Xx1HIv1fiOBqVjM7injTxjzIPB/Kn6x8LjjVwePmLydLskMbWoC1seqU5+UslbmHX1fkSABWX
	HDebD9Y5YNf51VOU+jqwMnd1MqwRBnntvVI2W3k+v5q1/YXDmgXxsD9wA==
X-Google-Smtp-Source: AGHT+IHf5MuUuxzNCJmijwlpIzlwX0C+FZt4N4hFHSCsNN5A/MhEygTFNw1wZ5Zd3/QcjApdtWN0lg==
X-Received: by 2002:a05:6870:b311:b0:29e:3c14:2bb0 with SMTP id 586e51a60fabf-2a3ac861bfemr10650494fac.30.1734456108405;
        Tue, 17 Dec 2024 09:21:48 -0800 (PST)
Received: from [192.168.1.184] ([136.35.146.47])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2a3d24b1997sm2893336fac.5.2024.12.17.09.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:21:47 -0800 (PST)
Message-ID: <a46c8d8c-39a8-4519-b80e-54dd4b2bc2bd@gmail.com>
Date: Tue, 17 Dec 2024 11:21:47 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wiphy: add info print for MulticastRxDisabled quirk
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20241126192433.102300-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20241126192433.102300-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/26/24 1:24 PM, James Prestwood wrote:
> This was forgotten in the prior patch set. It does not change any
> behavior but just adds this to the driver flags debug print when
> IWD starts up.
> ---
>   src/wiphy.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Applied, thanks.

Regards,
-Denis
