Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBACD42AB5
	for <iwd@lists.linux.dev>; Thu, 11 Jul 2024 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736050; cv=none; b=pxZRBjRrow6TDZhiPoxZkl7sAStqS5O4MiTNQ71o20/rHB7g5agYx9vUaQXvDlrWrB4cNNW2TZByFp11bO93Ek75iDlxVb8HbTNH6sUL+PGLnedh8FebTKT0+9ae3TsJ2qp7JsJbDeo5eaeoJABQNh2S49aNdSBuU2843egDQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736050; c=relaxed/simple;
	bh=ImGR9K2f3bEVkDzppxVqsS1kFxL8+zz3Lyl3LhS+fJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O4pbRTaTePl8fty2rNHsHItTw6ISpS46ImYq3D8qRAwIqZGN1eoW22e9IIP71JI/roE5NEsM5vg67kdMNrTXcPbVzx4ad+7Ex9434dp302wKka5+6O6I9ZlybkrRYIl9OdKx5ZSimPDwUrfdk0Fc7oKfH2x967XEATwm38SivbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLjry208; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLjry208"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7fd3dbc01deso62317839f.0
        for <iwd@lists.linux.dev>; Thu, 11 Jul 2024 15:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720736048; x=1721340848; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YadmHUA0U/DguVxGBQNXIbdRhKylO7MQMQMjelmNRM=;
        b=lLjry208rb/XPhHNLVrBk/YPnXz6RDIty4GuRg0GhbXvyyEZoxsvviBUNSwjvKOR4b
         7Ea3vvGdoUY9hpRXqqJLWA4H6u5CpCvqRaMqmARTIbB2xu/2gipbwrUH7Q/jgVMdvKIB
         Di4PSTcPdH4+WjSm/69VgHpKECD/LmSnLNQYujl25jrXJ3BwJ6+ny7ETrL1+jYxtxpuq
         UclKpyXNaHsllRTd3Ch3n2vWHHsUTY0PloBRMuOt14jAoz84OsA9bJKl9f2sy7ggTcW+
         Z2b7VBOJIkGYsT0KIhdImVF4aK4X8kMLL7ZH+k99Mg/wW/veEU9sBhWwKC5sWId8lZY7
         zAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720736048; x=1721340848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YadmHUA0U/DguVxGBQNXIbdRhKylO7MQMQMjelmNRM=;
        b=UtIEAlHzziRz3pcEz8kEmyb3/qZHlNPh36Yu56fmrVqiZi1HS3OOXPzMeDUFY7b8Gu
         CqzCtyCqz/Al2TkHLxgvSed2HzWYBjRjbXjaD6QH0rnJKkXODTNYdm2tlVTtPx9SMxL7
         /zqQa2BjEWLmOdUYpfC8WCUsOyOukQ2cy0rWz18fZQduJv3st/Rg3U9iCVfUNwFtpeFg
         C66uvvX4mjhBqdWBXpNTq4WIRTZp+PBb8E1pQGSB2dhKA6GoIEVoCd1yDcCtclbBVxN7
         SwSVNKB1qHMh8+HB/5iUCK5R2qN2SzMQl7q7LGYQAyAsprnWYYWYUHv8mFxvIjhS5WoO
         slTg==
X-Forwarded-Encrypted: i=1; AJvYcCU8AU1awHTDiR8ZrAmw9hssbBi1/HjjZU0CVnbQF3Dg3tNFFT9pPnv4sv3nY/BEI9fiICsgFfz9rZP4EgqaAsP2t1ok
X-Gm-Message-State: AOJu0YwtApcAYPRcPR37L6IA3OTBWGe+ixpvPQcCqO8raRWPffZA1EPi
	OrCprXvN7WZSv1twXkOiKiWcB1y07snd+zFVxfG21cUsbKMR0bmn11LipA==
X-Google-Smtp-Source: AGHT+IE3RHKWcODLJ8HSsix+aCOywbqDgNa5MVR9hS6dutI3cUcjdVaqlrTzJ3K4IJTMGPOQL3somQ==
X-Received: by 2002:a6b:db0d:0:b0:805:e2bf:f303 with SMTP id ca18e2360f4ac-805e2bff70emr535477439f.8.1720736047804;
        Thu, 11 Jul 2024 15:14:07 -0700 (PDT)
Received: from ?IPV6:2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3? ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c0b1af8404sm2057407173.34.2024.07.11.15.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 15:14:07 -0700 (PDT)
Message-ID: <f8ac159a-95d4-4b15-b2b4-db74d8c369a9@gmail.com>
Date: Thu, 11 Jul 2024 17:14:06 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] main: set the identity in the logger
To: Steve Schrock <steve.schrock@getcruise.com>, iwd@lists.linux.dev
References: <20240711220753.17831-1-steve.schrock@getcruise.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240711220753.17831-1-steve.schrock@getcruise.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

On 7/11/24 5:07 PM, Steve Schrock wrote:
> This causes "iwd" to be output in each message sent to syslog to help
> quickly identify iwd messages.
> ---
>   src/main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

