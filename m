Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E34EB44
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066054; cv=none; b=hgZri5PURij2BKNsLrFrc2Ox+CjUc5Vome9TADdSGqCdVOmdDWqFXGFvQVH685ldv8BtuQGOD7B/suoFo2SbMSFwV6/M4TkJX8u9I6fZDwezT5yZa198ANKxiiV3j2vF57m3ttSpfKX+J0BiqPzH6DiSGSH42oUs7f8uBsKi0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066054; c=relaxed/simple;
	bh=hosi9/xTVsJ6HHnL7k6KvWn4qqsXqCBjtsQS/gszrR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CfOKDNUsU0CBDvg4Vt+XDRF7lsiEvFuyWhGepVhT/qTTpPDnnyCxo4OJt2ZErS6AObTN0UkuWwN6nh5DbVHGqlMhTz4ajiMrO+CkVgroOAuFX56I253i5B2mFs07tXODchb7xW1D3+7HKNjNBhj++224DvTFKfN5N2/eR6bTa2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yqt2sRyh; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqt2sRyh"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c19bc08f96so2739362b6e.2
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 12:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066051; x=1709670851; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vu9kp8o4MKLOea/HHMHT2LLuuQEEvxJX0wrbYQMkGTM=;
        b=Yqt2sRyhUJ37RfaMb01hAvmS/0NNrE4jbf4w6/Ce3+Dt7V6smovT2spZ4oD3gXnbYN
         hc0QCSm1G6MqTNnQv+53p7mNsVEoWp/J61myAP+HhKez7T82FkuLkBh5D4RojHqfW9wH
         CviODqWHvUsIkxBImBJWqUw/HPit36UaK7TMRMgqN1TmnCHVNXIFhNrAxuCRVnO3deAQ
         lYSb0WVmxpyYQR/et33eVNkQrpqwA9zKFN0Jsw/Iy3QcPNrFygcvP8Dcfk1zq59D9Ek/
         JxaJrUSH4vKQsPkVqZNhYVYQnSfyeegLprpylM8bwUZdOTIpcB56VS+hwooU9L+gJWAg
         Jztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066051; x=1709670851;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu9kp8o4MKLOea/HHMHT2LLuuQEEvxJX0wrbYQMkGTM=;
        b=CYSaVbTSeECyHex66YrNB3+s2cVC0s1aJAhiEnAAZCWjnCWuyBaus01+jcfizjRnA1
         dwTsb+LZlf2K/lKeLP/GgxHrMTkjF86dege+WvJE3q3J7UHkuNtrTh6bj5MA3TACTXzk
         pBYp6t4daWhS45q5ydx5HKYbHqvBpU0GAwu9imipKOREFbu8D8ak2R8UqMLDG9Nlh+ms
         4ITX8taHdUfS2FxDORB3E9vPh9T5vkt7RdWfRibGujueLS+tWJZ3NGca9HVoTWTMI+sK
         2pohvUF8aCZ3/IqUduFoWC19qpznp3kYzDSbkOBkoIYWXm2Vf5cjx7zSTOyDPzmjTBEe
         OcTw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5ZWRBV5/GrqYImzYnDsVut/8zIAQiQvFUt4w4mUcK7RZPB0kIrG8iiy7KxoNLuIOhw263BQbKSZfEeb8TxSoLvTk
X-Gm-Message-State: AOJu0YyG7j8GEoHSIHhJcpV/o3dk7TKlvDV/wPNdtRzM+BBGdFzfPPR0
	PzksckLF0WzuUis4bV8GandHsFx8AAfcOXfrTArCaPKuVSJNn0Mv
X-Google-Smtp-Source: AGHT+IGyac7B28mdCiYZX/suA2fS/ts+TSSSTL/5C5GOshKKONOst0Su2Y099UMsZYu0OLm4rt4YDQ==
X-Received: by 2002:a05:6808:e8a:b0:3c1:4d83:30dd with SMTP id k10-20020a0568080e8a00b003c14d8330ddmr3440112oil.13.1709066051720;
        Tue, 27 Feb 2024 12:34:11 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l21-20020a056808021500b003c167e590fasm1562581oie.11.2024.02.27.12.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:34:11 -0800 (PST)
Message-ID: <69cde805-7693-4b9b-85f8-0273c2cbd105@gmail.com>
Date: Tue, 27 Feb 2024 14:34:10 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] unit: fix memory leak in test-dpp
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240227193521.304643-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240227193521.304643-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/27/24 13:35, James Prestwood wrote:
> ---
>   unit/test-dpp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Both applied, thanks.

Regards,
-Denis

