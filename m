Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4281D296
	for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyVCtPLe"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b2e330033fso1320096b6e.3
        for <iwd@lists.linux.dev>; Fri, 17 Nov 2023 07:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700236084; x=1700840884; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXVXZv0mDC+7EbQ2sLkUoS37+9pgGJqpw/z1zTe1xKE=;
        b=EyVCtPLevI7Ajd+DrB0l89FQR6fEx3mF8UXt6d0ykPCzMoLe6eC+VHkCpzjxzeEVWy
         TDGcnaTq0D3MDn1r744Flxs4eB62MuSJyuPgXe1xAKRl0UX8TY6JeruI/Pq5Z1Rr8sVS
         /H4eq5qCUJnzTuGddHUHr72Bqw2se0PIfJTMq+zSl0uqhhDgWwILrWwENtjYovJ63nuz
         MkwsJoSgVWeIgOrFa7iUgVvB/4ZMPK0i4XXUj+qgrwLMfYEe1r2yW19+JJn1I1LJVf1U
         Tap1ibPmvszMfvZiJaTgf2JTG6D3oEUpEzYtTUG51f4UgmynDhD96p00e8DuzUuD4e9J
         OvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236084; x=1700840884;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXVXZv0mDC+7EbQ2sLkUoS37+9pgGJqpw/z1zTe1xKE=;
        b=YpK7ZJ8XCINHa65kolg+3WtaddVA6LDsIjCq5vzeunUEq/q5VztzAevWDvAbP41ONq
         acIilEebWM8ev5tO1ssI9d2qi8X9GaetT8pqzqbwaPn1tfh7wVveDdZ7cVp86kX6bZ/U
         DgMLIGdJxJvmWp9mWxQc+G6QP0tdZUKAgsraxTsiAyu9haR/AuEcrhUPbI9FW4Sl9fFa
         CBXxxVAjjjn/Y1NEYILrh/TfOdpKtJ19mHicPAr5T9lxNsAfZjdyzhWPyG/qC67b44AR
         tA23xTxeb8cWeIhayIyrfUd5OYhSqIgPlg2Qo0pZD03cmSfs8FIBBawmDM/ocJgsEGmE
         QN0A==
X-Gm-Message-State: AOJu0Yy/HJbKNoZ/GhkCQm5wOdN0rN01pPsYrxTiMJSojoH8r3RjtK7y
	Waatwxs82LBw7D+7HbY/iaY=
X-Google-Smtp-Source: AGHT+IFeiDVKUkzRCrGccAF0mK/So6+Yvo6OhyoqxPe684s8HAMfL8v4LNCafuIf2lJTgSfgevfjfQ==
X-Received: by 2002:a54:4810:0:b0:3ac:a4ec:e136 with SMTP id j16-20020a544810000000b003aca4ece136mr19473654oij.51.1700236083791;
        Fri, 17 Nov 2023 07:48:03 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a3-20020aca1a03000000b003ae59076b90sm311807oia.14.2023.11.17.07.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 07:48:03 -0800 (PST)
Message-ID: <e6d24aa8-68b6-4420-87cc-e8f916506961@gmail.com>
Date: Fri, 17 Nov 2023 09:48:00 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dpp-util: store SSID as string, not raw buffer
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231116191528.364340-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231116191528.364340-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/16/23 13:15, James Prestwood wrote:
> Nearly every use of the ssid member first has to memcpy it to a
> buffer and NULL terminate. Instead just store the ssid as a
> string when creating/parsing from JSON.
> ---
>   src/dpp-util.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

All applied, thanks.

Regards,
-Denis

