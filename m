Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593B81C
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQXo1UH/"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d7f3a4bbc6so2249057a34.2
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 20:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701060063; x=1701664863; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odS6NlPcSBprEiK/4sWE53PNlTypxTIx63jLvJ8umAA=;
        b=KQXo1UH/xpvdJqdnqryymXbfuLqkq2f8DICZVGG4ER9n4kPkFGurd8YVE+tpA4uOc/
         rYeZ0A9mt3yOTp4+kEaYztZJKGQEM9oWyhXdxRR4pYMlgk54CoDfqEg92FVTK5C+ML2w
         7ff3X0sk4q7aN2RhNGEOUNpJETgu6Pix96WCxEd9BqFnO84wkcKFuq0uTpl8pCXD6aGF
         aYu2QV3KK/DzciE0durGEhnudcSOn5KeECMU6BJRR+BA/ewzFX0UepES7rU1sYXL8GXE
         zw6yW2dqqr+otToPg7kLIxdwKDyIdgMqTwPkUM/kBQa62wR9lemCzT4Yz/qu9pk/F54c
         A+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701060063; x=1701664863;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odS6NlPcSBprEiK/4sWE53PNlTypxTIx63jLvJ8umAA=;
        b=mkr+tWJ1UMDAC+ATqymZrEDVgfocJ1EaLQIZeZH3ox0Th5LUckD5ch21HcxKbjRL1f
         Gl0sJXQ9qhExSB2rRCv5uP4+fuRMJ0qqxcamMqfTqjDrFTic1YLWf1UHnqg3ezPGPscO
         otosf/HRaervh8ECmuI/KRQmdFfkreclZjXyEsIW5JOYz9o3G8w5AyxwmLiPXUDupc5y
         h40jfr/dkz/ANaPCb3q2zFNKHVReXnzyrKCMGzLFMiG4UHg81YXjrcKp3O6rFSOtBV5c
         4+AvUzgWSgEbR1XouWbFVkrGLIGQ8H1A71QWozwJxEGfvwhEnVlPGKuKka0NJiU6zhX8
         2f4g==
X-Gm-Message-State: AOJu0Yxl9dT69IsDVhMFgu6fbVGI3pwoPFPhTAW23iuwAzKPqAYrK6ev
	72+x74ALRA2Gs57QBNIAF8bvJkoVUJg=
X-Google-Smtp-Source: AGHT+IGgHdbLm9ngzRepETG3oorxzO58MJZC1BYDP1CjoOVQKXWm0sxIFic5zNxzjHQiCIk/JMH4fw==
X-Received: by 2002:a05:6830:12da:b0:6d8:187b:f2e with SMTP id a26-20020a05683012da00b006d8187b0f2emr5801289otq.24.1701060062853;
        Sun, 26 Nov 2023 20:41:02 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05683001c700b006d7eb79ed4csm1258549ota.6.2023.11.26.20.41.02
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 20:41:02 -0800 (PST)
Message-ID: <9037d30e-ed47-4842-a907-5ea2fd054a96@gmail.com>
Date: Sun, 26 Nov 2023 22:41:01 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] netdev: Do not leak l_genl_msg on error
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20231127025320.1310543-1-denkenz@gmail.com>
 <20231127025320.1310543-4-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231127025320.1310543-4-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>   	netdev->connect_cmd_id = l_genl_family_send(nl80211,

The send needs to also use connect_cmd, not netdev->connect_cmd.  Fixed in v2.
