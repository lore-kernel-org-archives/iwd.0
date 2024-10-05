Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089F1C687
	for <iwd@lists.linux.dev>; Sat,  5 Oct 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728094806; cv=none; b=md6WUQGYYRiyZnpX3gAGwmA9U2QPm0QTh77yhlbHd9kRG/rD08C6RVfQnFtpMDzTvcTkdGW77cyOa7x+wK7JkAE6Y6Ij3dFvMPZsHXOWM5lj3PXwRFNdM657uT0iFE34APH+OM6jhFhbPyr6VvfPfht0arZd83QBZovzp5dt7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728094806; c=relaxed/simple;
	bh=5QwICuwncs72T+klpkBkCzALP4ZytXnEbpwtQg2QZ10=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIj/Hd8AWzxJJCYm0tsj6wkr3jXQJJhZCl56p2+bYGxIrPmk9owbR41t0TXolT/Du5oj/jBQxSk5VGc0VzrMLVnVGagjFyYjbr8Uyq11kFrlVouSiIomWJkkuS4/4yXwtY+54lLZsS1CYSvD9IjKmmM5di+iCjqI8LHyWuD0UMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MJbayUMX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MJbayUMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728094802;
	bh=5QwICuwncs72T+klpkBkCzALP4ZytXnEbpwtQg2QZ10=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MJbayUMXOVLUhEwtEJaoRgqb7xZ6qWIa7cfm5CeS5d1I9uVRmqxoi1L+NPfdtpNVw
	 9AwciP2G/+IQTi7drsu6Mp5Wy+toznDLR2h9vkQQmEjoiAeCr/vJJk2ZqidTVuRyEd
	 P2y6hWBJGCvN3neStJanric2O0J1aNbvD8/M1fJTLJ9LwgjIRJ2znsH0vqrwH1XwR4
	 bgXGg62igm3a1oOHTYgEvYlqU4nYyuwdZpVFhDhQsfSl2zy2ZuC4UqJfJNC5XQFgg6
	 cdqcn7XzMM1/sespTE9nVl59vMDegIx8s9oJWJEe71uXyfQX35qEMsvv4MDajU0BYL
	 +4tvTt0Qbp8mg==
Received: from noise.lan (unknown [IPv6:2001:4d48:ad5d:8e00::197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vivek)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C81C217E0F84
	for <iwd@lists.linux.dev>; Sat,  5 Oct 2024 04:20:02 +0200 (CEST)
From: =?UTF-8?q?Vivek=20Das=C2=A0Mohapatra?= <vivek@collabora.com>
To: iwd@lists.linux.dev
Subject: RFC: Be more lenient about duplicate IEs with identical payloads
Date: Sat,  5 Oct 2024 03:19:27 +0100
Message-Id: <20241005021929.2075817-1-vivek@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <6dbd0686-f054-4c16-bf84-0e383baefdc9@collabora.com>
References: <6dbd0686-f054-4c16-bf84-0e383baefdc9@collabora.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I think these patches do the right thing:
 - duplicate IEs with identical payloads don't count as validation failures
 - the duplicate-IE test data has been altered to make the duplicate IE
   have differeing payloads so that test still passes

