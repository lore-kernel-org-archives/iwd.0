Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28B4A32
	for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 18:14:50 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id i10-20020a4ad68a000000b0053b8aa32089so3439205oot.5
        for <iwd@lists.linux.dev>; Sun, 16 Apr 2023 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681668890; x=1684260890;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0Wwe+aT1YKpxMflljP8Y6yhroZFOwW+zxSS8P1hXBI=;
        b=ik9PZ5zZ7U6k8FohHr0r99muz6Nkmer/pf19YMBtLJwRqegJA43bHEnMAq/gI5YiWh
         Sb2ncaql2EBPhsbgObzLfeT8iOHAmYIHvAP5K25cl0W2iC8clu3dVBsaQTYYaOt8V1WR
         AxFziw86ZAoyeOjbiGzZEiHTNDJqVgxtXsmU/2xDteOi/b+5dFnqsC6CiiTaLeNVG++t
         sffQ3xTNd6oE8UIKLrvv9owxcelyh8ql88LpW65ZQfQMNyasR5AwUVTPbqFJGfZ/43fm
         PrSIAVo6ACGXeagQCm5pXUgkVMhowIb8g48YRJgKyb/S+e3PAxApibR4MNSxUmrFEMsc
         3H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681668890; x=1684260890;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0Wwe+aT1YKpxMflljP8Y6yhroZFOwW+zxSS8P1hXBI=;
        b=eMFWe16meRLWp66j7TMlykpHqjOEc8omKSRHy8wUQhP/B61UVuVw8mbl05r2B0bdXS
         SVUah+Zvwz8Oi/iBgwNF6xepPGKbLMaK35A9AT1/gxGNPzY+zlyTKK/FrS64PpLelm+D
         wGLZfj3nLXM9H7MR34Sexs6ITu5K0ruUZrMMjm1Lsq4WVctrgTwTAgEheA70QLvaH3az
         KQt9iNLpOAmxRfTqan+z4UmoV0Fk7S/YNZZxBs3J1hVpZVQ7l9gJXQ5dKD6E4fnk7BO6
         F7+sbUuccFS1WO54po3lhaWlqN6EfqwZjbBxpav3QnzRCNldQhcqs64Tl9DVubBsKzzW
         eUDg==
X-Gm-Message-State: AAQBX9exTemG54Ne2a98igv9sRFBf+2/XQ7js8PTyxx4waTiNgwNNdv8
	DKnDxDC3HP50G0a3yEU7vrloiqP1/3mXWA==
X-Google-Smtp-Source: AKy350bpg+WuzZTKm36QbVgdlZv5pR6ET845mtK+xznhXXbyX0q9XvNRMhnFwD/8XNyG8q9m/GMB4w==
X-Received: by 2002:a4a:2c83:0:b0:546:3e27:9c86 with SMTP id o125-20020a4a2c83000000b005463e279c86mr964919ooo.9.1681668890158;
        Sun, 16 Apr 2023 11:14:50 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 187-20020a4a09c4000000b00525240c6149sm3934676ooa.31.2023.04.16.11.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:14:49 -0700 (PDT)
Message-ID: <4a2501a6-8c96-5eb0-6a5e-f9afbdb2df2f@gmail.com>
Date: Sun, 16 Apr 2023 13:01:29 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/9] handshake: remove hardcoded kek_len for FTE decode
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230410220135.373872-1-prestwoj@gmail.com>
 <20230410220135.373872-7-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230410220135.373872-7-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/10/23 17:01, James Prestwood wrote:
> The KEK length should be obtained with the getter to ensure the
> AKM is taken into account
> ---
>   src/handshake.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

