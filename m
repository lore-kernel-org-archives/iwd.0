Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E430CEC
	for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrpVROfO"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso422658fac.0
        for <iwd@lists.linux.dev>; Thu, 16 Nov 2023 07:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700149683; x=1700754483; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DccezWdSMT6yRo9L8xCC2VcnkLYfW8AX89EH5PRe+wc=;
        b=BrpVROfOdl34idP93vHFm3jgvB7jUJHfvbwYJ+eURCCaalquqbW1nhW9em8W5Hl2/Y
         ost7mw5xqGnTjWwLYc9g7hfVK8iTauFCCawkPun+SPLEOsXQ7n5eNQfkfLCP8pinBtyF
         RPV0jNl0Q98O1Xnwui5Qdua/krJycYKywQpiElPcA9zsKLIbE6l9AOXkLRQBTjdK9iqf
         yuG2koN4YlXunBXxyW8r5UihKMl++kiHPUpFw99/CDS6/1Yi05URjXwFgH4QD+f1eaia
         xol4oZQpSb/E7ZU+TmIyYokIQF5T/uNWk2wBDU3zO+pVrpM38hL2QSs6M856u9DC/P2C
         rzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700149683; x=1700754483;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DccezWdSMT6yRo9L8xCC2VcnkLYfW8AX89EH5PRe+wc=;
        b=roIjd5rYQkLrPL9mdhLN08ou7D1N6EVfP6ec9jAj3q/Pr//aqWO2n7O+sq3cTRUsUw
         TVV9bnPzQ2WGsELmiU6wGcwWXWsPD80B5rAKpVAu/6UeCenXOJx3ewSvH81qz3wYlzvg
         Tu68AXcAWcFWxZ6MCml12FX2l93Ouh6GqVCSeW0VUqOoxgIv5MLcU8ci6AYZWyBxq05b
         hmJFiFkulKrHkZYThgsih3kGwavGnq6Z7tXXymMbubR6gtU4W+sz6QmiOUGP5DcFwe8u
         KQRpVaXQHPIf0SGrKiJMuOoHdR9LEcCGnl2y9yp0ME2Km4U5o5jYT0ST2+RLeLrcdeKV
         vS4g==
X-Gm-Message-State: AOJu0YxvHbZ9RkIvkq2HXYS++Hv6AxIh+YbBHKBqOqL81qoP/U95J8Gt
	eKxFQgxzPjyYDfJ41PciWgg=
X-Google-Smtp-Source: AGHT+IHqeWzABg/bNJsQhqHoVI0xm3WWSOhZq058KNtLgnYZzIb6I08zMVbDdxq13HBroGACGONVwA==
X-Received: by 2002:a05:6870:c102:b0:1f5:5da4:9355 with SMTP id f2-20020a056870c10200b001f55da49355mr5592139oad.57.1700149683375;
        Thu, 16 Nov 2023 07:48:03 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ds51-20020a0568705b3300b001dcde628a6fsm2179185oab.42.2023.11.16.07.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:48:03 -0800 (PST)
Message-ID: <88c51eb0-9fec-4600-b134-58e7b4aa0fd3@gmail.com>
Date: Thu, 16 Nov 2023 09:48:01 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dpp: check that DPP is running in station watch
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231116154439.33880-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231116154439.33880-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/16/23 09:44, James Prestwood wrote:
> This was causing unneeded WARNING prints because the DPP state
> was never checked. Fix this and bail out if DPP isn't running.
> ---
>   src/dpp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

