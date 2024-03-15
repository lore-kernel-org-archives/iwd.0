Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E82E62D
	for <iwd@lists.linux.dev>; Fri, 15 Mar 2024 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510438; cv=none; b=mLOdPdE9cRfg6ZzzkLi5vjiD8NjGiDDJ/2lpiPO/bN2wKqcJUclWSpW9UaNlmLOZ4h2m3vjSQKXblZhfTGb1jc/ZV9VonH8nd7aWr++C9BX0kSw1I6rv/H1VSwRwbpPPpRMGxT443ByoaI9IuVfkf3qAFZ4u8KE+ydqwrg3Wb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510438; c=relaxed/simple;
	bh=Lxm0MCe+LZ7K+pwuczaIYoJ0Ktwk+1Fp+3lXCIFQM5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ec4EEnOJCWTfmG9akxGq6YPEEcQDwwT51idhVE0qdWzfoCEhG1QFxDRYvEvucg7edxg7IXFyS8yuYVRhPXyWcHJ8ruBMV1JrAha+GMtweb4puhFE9SakSZ3l5k7mG36ZLsoxWcdc3AG5UgjlfVqW0YprKmP0zZdxT+HD+Nvq2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9/t6Sv/; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9/t6Sv/"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbd6ea06f5so958676b6e.1
        for <iwd@lists.linux.dev>; Fri, 15 Mar 2024 06:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710510436; x=1711115236; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvCRCImRGqijAzxKUz/Vor0oS2+HEGXugmX7Ahhvn5E=;
        b=N9/t6Sv/CNylNn8xGMTDqi52KtVDKLAf3MotIg94MN+gvWeuIaX9S883o9fjZqwY9v
         AeCZq25W17lPtgsp6a0XCapRfxulQb4p4DR71Hjxg/9SNqj4khsAiQQkdvZlS4UlUHFB
         XyeuU/6+SLa3Dv4v9uPzkVAgo5gbW/9KCgzY4C95v+Rv14kNJ3+hwuaNzhK0sAu/Xf4k
         TCfOhAasVMV3+0jXppasauuCTY0y9ON75Oy/tsn6CopoOMmoLtu4lXrzwWMPF1dXeD+e
         y3qrbfBNuJK1BR4aEv0Ms4egCaTADkIjBCYB+jXRC95rIfq/lcVrT3+EbEV8OLHKSWLL
         elOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710510436; x=1711115236;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvCRCImRGqijAzxKUz/Vor0oS2+HEGXugmX7Ahhvn5E=;
        b=w0cf+dUQf9H1v31OwRyl01nur2F9ZYHTnpOdE0qlQG17QLhs+o1ylaOFjc/kXDy4xo
         eMGF8sAde3tIn6lxCjWujuNQdX4ZAw7YiMgh+41cUWHKvAlC/ru3dZtIuJbNmRGDKi4c
         5AplYmnMiv/uGFKqKT3infWnnFcfUvQSalaC4sYJWj5GsIMCzGR3z0bnc9UvPUCmhtZG
         iSwcabM2EqFNcy8i+NKFLa8MjtrzfcLhXsfNFUi4mxQkuXjSNjhdnirss+mk+NPMMHOQ
         3N0u2cOmI0wFjRphhuZY27XbXHpWCRwf40JwRIP8lKjANDwCIwPgjJ/cWGtV65Z/piGS
         aasQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+pEbTvxpqxUQMCBkq4/mF57zYtW44MO5S0VTRE81OlWiQdmES7OhbgTgdMzTS74K8eFvt3AJv8+iSszEq6RcZaydr
X-Gm-Message-State: AOJu0YzRAuSe0Iq0hajSzGyVZc3379AmkbT10IlfBINLzAkeKiOdxcM3
	qx39sCQl9Tcr03DajbAWr/9lNIeb4kmiqh973CEy3P7E7QDW6wW/
X-Google-Smtp-Source: AGHT+IEDBwIuFxWkWIffZkYv4jC/PoRdcMMp+BQht8MsJGpY1zgiu+G3izZBvWA8XXbvhO8cZgRK0A==
X-Received: by 2002:a05:6808:2381:b0:3c3:62c1:ef13 with SMTP id bp1-20020a056808238100b003c362c1ef13mr1875799oib.11.1710510435825;
        Fri, 15 Mar 2024 06:47:15 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bm12-20020a0568081a8c00b003c1e9fc1a20sm621053oib.28.2024.03.15.06.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 06:47:15 -0700 (PDT)
Message-ID: <5d52f355-3c05-4b54-8eaf-3baae41aec99@gmail.com>
Date: Fri, 15 Mar 2024 08:47:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iwmon: fix incorrect mask printing HE capabilities
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240315111821.116213-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240315111821.116213-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/15/24 06:18, James Prestwood wrote:
> This was changed from too large of a mask (0xff) in an earlier
> commit but was masking 5 bits instead of 6.
> 
> Fixes: 121c2c5653 ("monitor: properly mask HE capabilities bitfield")
> ---
>   monitor/nlmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

