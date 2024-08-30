Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F4C13BAE2
	for <iwd@lists.linux.dev>; Fri, 30 Aug 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035841; cv=none; b=VKd94qepkFieYxuNq8w/Nd8UN9xNeBFRPTLc43HM9stPNVLQ0YS0x32jB3LPBarX+Q3e8YCfS1GL3vnptmi9/Yjujm/UTRP4pw3oUe/SYuztGYdeORgKoPELVnY21nNWhvnaBEOAXK7pTg3fmhQtPJcTQ+T9y2dhECicXT3xvPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035841; c=relaxed/simple;
	bh=bcX++iNvt2B6f7j6pzzD95Q9mgrJ/gCwaFrhYFcdqbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qKnLZoQO2IQowrVNhubZQMHkXGAgLYCTx1lSe5+y8A4Q7MxBHIOJ0R7ZTPv+s6BughsjKVKNYJQdbuqvGjkAEm8HThmDYej2OdTLqXvFvU3xY8W5XECg4t48+N6Qz54f7GybycFCY+UoyoS5KrhGyPobYkud6gOH9oikmbcmdP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-69483a97848so18800747b3.2
        for <iwd@lists.linux.dev>; Fri, 30 Aug 2024 09:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035838; x=1725640638;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/z1iB6hAJHB8yCJwYt4zNv+5/K1NJxOa9jcH3GKvbg=;
        b=YC7ARw9nr1TrjlvOQg1AKH77KIOdDRHb9OFbr5BhnGIDPa0vZNxWVipT9PEX0gqr1S
         K6WZDTfzbxI97iPHMJTrZmn63L77ODZo6YkTzfBDhPsZhVTSQ0i3RE03tfWAiFzb0ir5
         0QJkjZVu93nrT7uRWdquxvU1VhuDtZV7BaADDHvgTWZVyM+8h3fmms9aJ5X0SHvL5FBq
         5Yq83ShhyeL9XuerPTn+BY1doUqNFE96ngz2bwEZb+tgeHp9rc200LTWnPnmQoV3402p
         RzQRXz9QwBJ2Gn3qPfGqjnnOTKMGtD7UGRKvz00M0mBDNXuK9Bwi8VEcnOYVXu1L//Dl
         /ONQ==
X-Gm-Message-State: AOJu0YzdUAzmDrsElCdat0s9CXpXtaVHvFNPw5QM51Ivx248dI79v+jU
	iOFljAjERL9QQHyflTNCCiIndXxi7Sd+U2XJ68VggkOWMyBTtE9yEIqdkPhm
X-Google-Smtp-Source: AGHT+IEVt96DSpIMLl8x1e9gPSW+9Vkhk6UeUTUeli62mK9cAzL+SYXmj+SOsocgwKaWXNPwuiYZ4w==
X-Received: by 2002:a05:690c:dc6:b0:64b:7500:2e9 with SMTP id 00721157ae682-6d40d987abamr34742397b3.9.1725035838212;
        Fri, 30 Aug 2024 09:37:18 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d5daebd6sm6737877b3.105.2024.08.30.09.37.17
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 09:37:17 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e13cda45037so2060145276.3
        for <iwd@lists.linux.dev>; Fri, 30 Aug 2024 09:37:17 -0700 (PDT)
X-Received: by 2002:a05:6902:2502:b0:e13:cd7b:1da9 with SMTP id
 3f1490d57ef6-e1a7a018ea3mr3292615276.33.1725035837103; Fri, 30 Aug 2024
 09:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAG17S_N+Hjt2c8t8hN4VMx79QsQ3hiiE_cwOErg6fKoyHkr67A@mail.gmail.com>
 <ef38aa12-634e-4870-888c-219c961f301c@gmail.com> <b0ef10a2-c30b-4b6c-8370-66f9e0ace7b1@gmail.com>
 <CAG17S_P_MO4_BZYTCp4WDkJ_q4j=0s_s3azCOWrsvqmLD0ravw@mail.gmail.com>
 <de951e97-547f-4c14-841c-267f64b0020b@gmail.com> <CAG17S_Oh_1NS9SUSadAJkMXtJ3s_AjMhnUDSqrKMzEiO69jBPA@mail.gmail.com>
 <cf5ba208-58d9-44e8-bd91-0639ea062d5d@gmail.com>
In-Reply-To: <cf5ba208-58d9-44e8-bd91-0639ea062d5d@gmail.com>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Fri, 30 Aug 2024 10:37:05 -0600
X-Gmail-Original-Message-ID: <CADXxVSLa+DF9CRWy0Yin7cShrwauQw0=EC-i+MuGnxVcB+2n3w@mail.gmail.com>
Message-ID: <CADXxVSLa+DF9CRWy0Yin7cShrwauQw0=EC-i+MuGnxVcB+2n3w@mail.gmail.com>
Subject: Any recent wifi certifications with IWD?
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,
I was wondering if anyone had recent wifi certification experience.
We are working on a new product that will get certificated in the next
6-12 months.  Last time (about a year ago), we had to switch back to
wpa_supplicant last minute because of one failed test around PMKSA
caching. IMO it was a pretty ambiguous test, but couldn't get the wifi
alliance to let us skip that test.

There was some discussion at the end of this thread:
https://lore.kernel.org/all/504042cf-1704-a590-391c-009b500cf505@gmail.com/T/

We got our testing in last time just before some additional wifi
certification requirements.  So there are probably some stricter tests
now.

If anyone successfully got certification with IWD I'd love to know!

Bryce
